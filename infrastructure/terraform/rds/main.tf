variable "vpc_security_group_id" {}
variable "db_subnet_id" {}
variable "db_subnet_id2" {}

resource "aws_db_subnet_group" "private_subnet" {
  name       = "private_subnet"
  subnet_ids = [var.db_subnet_id, var.db_subnet_id2]
}

resource "aws_db_instance" "movie_rds_instance" {
  identifier                 = "movie-db"
  allocated_storage          = 10
  engine                     = "mariadb"
  engine_version             = "10.11.6"
  instance_class             = "db.t4g.micro"
  multi_az                   = "false"
  db_subnet_group_name       = aws_db_subnet_group.private_subnet.name
  vpc_security_group_ids     = [
    var.vpc_security_group_id
  ]
  username = "admin"
  password = "tmp_pass"
  tags = {
    Name = "movie_rds_instance"
  }
}

output "subnet_group_name" {
  value = aws_db_subnet_group.private_subnet.name
}

output "security_group_id" {
  value = var.vpc_security_group_id
}

output "rds_endpoint" {
  value = aws_db_instance.movie_rds_instance.endpoint
}