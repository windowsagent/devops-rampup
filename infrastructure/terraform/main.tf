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
  movie_sg_id = module.vpc.public_sg_id
  rds_endpoint = module.rds.rds_endpoint
}

module "rds" {
  source = "./rds"
  db_subnet_id = module.subnets.private_subnet_id
  db_subnet_id2 = module.subnets.private_subnet_id2
  vpc_security_group_id = module.vpc.db_sg_id
}
