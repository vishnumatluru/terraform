resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    name = "NAT EIP"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subent.id
  tags = {
    name = "vishnu_NAT gateway"
  }

}


resource "aws_route_table" "private_RT" {
  vpc_id = aws_internet_gateway.nat.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id

  }
  tags = {
    name = "private-RT"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subent.id
  route_table_id = aws_route_table.private_RT.id
}