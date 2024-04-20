variable vpc_id{}

resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.public_subnet.cidr_block
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet"
  }
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
