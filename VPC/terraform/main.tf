variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
    default = "ap-northeast-1"
}
variable "product_name" {}

# main.tf
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-east-2"
}
 
resource "aws_vpc" "vpc" {
    cidr_block           = "172.16.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "false"
    tags {
        Name  = "${var.product_name}"
    }
}

resource "aws_subnet" "subnet-public" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "172.16.129.0/24"
    availability_zone = "us-east-2a"
    tags {
        Name  = "${var.product_name}-public"
    }
}

### resource "aws_subnet" "subnet-private" {
###     vpc_id = "${aws_vpc.vpc.id}"
###     cidr_block = "172.16.0.0/24"
###     availability_zone = "us-east-2c"
###     tags {
###         Name  = "${var.product_name}-private"
###     }
### }


resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name  = "${var.product_name}"
    }
}

resource "aws_route_table" "route-table-public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet_gateway.id}"
    }
    tags {
        Name  = "${var.product_name}-public"
    }
}

resource "aws_main_route_table_association" "association" {
  vpc_id         = "${aws_vpc.vpc.id}"
  route_table_id = "${aws_route_table.route-table-public.id}"
}


resource "aws_route_table_association" "association" {
    subnet_id = "${aws_subnet.subnet-public.id}"
    route_table_id = "${aws_route_table.route-table-public.id}"
}
 




# resource "aws_security_group" "admin" {
#     name = "admin"
#     description = "Allow SSH inbound traffic"
#     vpc_id = "${aws_vpc.myVPC.id}"
#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }
#  
# resource "aws_instance" "cm-test" {
#     ami = "${var.images.ap-northeast-1}"
#     instance_type = "t2.micro"
#     key_name = "cm-yawata.yutaka"
#     vpc_security_group_ids = [
#       "${aws_security_group.admin.id}"
#     ]
#     subnet_id = "${aws_subnet.public-a.id}"
#     associate_public_ip_address = "true"
#     root_block_device = {
#       volume_type = "gp2"
#       volume_size = "20"
#     }
#     ebs_block_device = {
#       device_name = "/dev/sdf"
#       volume_type = "gp2"
#       volume_size = "100"
#     }
#     tags {
#         Name = "cm-test"
#     }
# }
#  
# output "public ip of cm-test" {
#   value = "${aws_instance.cm-test.public_ip}"
# }

