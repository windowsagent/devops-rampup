variable "public_subnet_id" {}

# Public route table
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.movie_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.movie_igw.id
    }
    tags = {
        Name = "Public Subnet Route Table"
    }
}

resource "aws_route_table_association" "rt_associate_public" {
    subnet_id = var.public_subnet_id
    route_table_id = aws_route_table.rt.id
}

# Private route table
#resource "aws_route_table" "rt_private" {
#    vpc_id = var.vpc_id
#    route {
#        cidr_block = cidt_block
#        gateway_id = aws_internet_gateway.movie_igw.id
#    }
#    tags = {
#        Name = "Public Subnet Route Table"
#    }
#}

#resource "aws_route_table_association" "rt_associate_private" {
#    subnet_id = aws_subnet.private_subnet.id
#    route_table_id = aws_route_table.rt_private.id
#}
