module "network" {
  source      = "git@github.com:irgashevsardor/aws-infrastructure-terraform.git"
  vpc_cidr    = "10.0.0.0/16"
  region      = "us-east-1"
  environment = "dev"
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [module.network.vpc_id]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [for subnet_id in data.aws_subnets.all.ids : subnet_id]
}


resource "aws_kms_key" "db_key" {
  description = "Key for MySQL DB"
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage             = 10
  db_name                       = var.db_name
  db_subnet_group_name          = aws_db_subnet_group.db_subnet_group.name
  engine                        = "mysql"
  engine_version                = "8.0"
  instance_class                = "db.t3.micro"
  username                      = "sardor"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.db_key.key_id
  port                          = 3306
  apply_immediately             = true
  multi_az                      = true
}
