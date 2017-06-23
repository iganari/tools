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

resource "aws_db_instance" "default" {
  engine               = "mysql"
  license_model        = "general-public-license"
  engine_version       = "5.7.17"
  instance_class       = "db.t2.micro"
  multi_az             = "false"
  storage_type         = "standard"
  allocated_storage    = "5"
  name                 = "mydb"
  username             = "db_adm"
  password             = "JpyNVfXWeTX28Ahx5f24mvZp6s8bQ3Qm"
  # 
  # db_subnet_group_name  = "default-vpc-69d72f10""
  # publicly_accessible = "false"
  # availability_zone = "${var.region}a"
  # vpc_security_group_ids = "aszoo-api-stg-ec2-rds"
  # db_subnet_group_name = "my_database_subnet_group"
  # parameter_group_name = "default.mysql5.6"
  # identifier = "igarashi-test"
}
 
