resource "aws_vpc" "movie_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "movie-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.movie_vpc.id
}
