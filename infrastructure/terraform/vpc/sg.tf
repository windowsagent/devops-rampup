variable "public_subnet_cidr_block" {}

# Security group for public instances
resource "aws_security_group" "movie_instance_sg" {
  vpc_id = aws_vpc.movie_vpc.id

  # Inbound rules
    # Access to frontend (HTTP)
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # Access to jumpbox through SSH
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  # Outbound rules
    # Internet access to anywhere
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

# Security group for RDS DB
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.movie_vpc.id
  # Inbound rules
    # Access to DB (MariaDB)
    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = [var.public_subnet_cidr_block]
  }

}

output "db_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "public_sg_id" {
  value = aws_security_group.movie_instance_sg.id
}

output "public_sg_name" {
  value = aws_security_group.movie_instance_sg.name
}
