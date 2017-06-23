variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
    default = "ap-northeast-1"
}
variable "product_name" {}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
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
    availability_zone = "${var.region}a"
    tags {
        Name  = "${var.product_name}-public"
    }
}

### resource "aws_subnet" "subnet-private" {
###     vpc_id = "${aws_vpc.vpc.id}"
###     cidr_block = "172.16.0.0/24"
###     availability_zone = "${var.region}c"
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

resource "aws_security_group" "sg-ssh" {
    name = "${var.product_name}"
    description = "Allow traffic on port 22 between ELB to EC2"
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name  = "${var.product_name}-ssh"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        # security_groups = ["${aws_security_group.sg-ssh.id}"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
        self = "true"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg-elb-ec2" {
    name = "${var.product_name}-elb-ec2"
    description = "Allow traffic on port 80, 443 between ELB to EC2"
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name  = "${var.product_name}-elb-ec2"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        self = "true"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        self = "true"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg-ec2-rds" {
    name = "${var.product_name}-ec2-rds"
    description = "Allow traffic on port 3306 between EC2 to RDS"
    # desciription = "Allow all network traffic between A and B"
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name  = "${var.product_name}-ec2-rds"
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        self = "true"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg-public-http" {
    name = "${var.product_name}-public-http"
    description = "Allow traffic on port 80"
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name  = "${var.product_name}-public-http"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

  
# output "public ip of cm-test" {
#   value = "${aws_instance.cm-test.public_ip}"
# }

