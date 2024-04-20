resource "aws_internet_gateway" "movie_igw" {
  vpc_id = aws_vpc.movie_vpc.id
}
