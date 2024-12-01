resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_pub_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = "pub rt"
  }
}

resource "aws_route_table_association" "rta_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.my_pub_rt.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.my_pub_rt.id
}

