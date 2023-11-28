
resource "aws_vpc" "devops_vpc_vish" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "devops_vpc_vishnu"
  }
}



resource "aws_subnet" "public_subent" {
  vpc_id                  = aws_vpc.devops_vpc_vish_vpc.vpc_id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1"
  tags = {
    name = "public-subent"
  }

}



resource "aws_subnet" "private_subent" {
  vpc_id                  = aws_vpc.devops_vpc_vish_vpc.vpc_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1"
  tags = {
    name = "private-subent"
  }

}




resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_vpc_vish
  tags = {
    name = "vishnu_vpc IGW"
  }
}



resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.devops_vpc_vish
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw
  }
  tags = {
    name = "public-RT"
  }
}
 