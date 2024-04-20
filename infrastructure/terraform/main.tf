terraform {
  backend "s3" {
    bucket         = "devops-epam-terraform"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = "true"
    dynamodb_table = "devops-epam-terraform"
  }
}

module "vpc" {
  source = "./vpc/"
  public_subnet_cidr_block = module.subnets.public_subnet_cidr_block
  public_subnet_id = module.subnets.public_subnet_id
}

module "subnets" {
  source = "./subnet/"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"
  public_subnet_id = module.subnets.public_subnet_id
  movie_sg_name = module.vpc.public_sg_name
}

module "rds" {
  source = "./rds"
  db_subnet_id = module.subnets.private_subnet_id
  vpc_security_group_id = module.vpc.db_sg_id
}
