resource "aws_security_group" "security_group" {
  description = "Allow limited ibound external traffic"
  vpc_id      = aws_vpc.devops_vpc_vish
  name        = "terraform-ec2-private"
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080

  }
  ingress = {
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0

  }
  tags = {
    name = "ec2-private-sg"
  }
}
output "aws_security_group_id" {
  value = aws_security_group.security_group.id

}

resource "aws_instance" "public-instance" {
  ami                         = "ami-02a2af70a66af6dfb"
  associate_public_ip_address = ["${aws_security_group.aws_security_group_id}"]
  subnet_id                   = aws_subnet.public_subent.subnet_id
  instance_type               = "t2.micro"
  key_name                    = "devops"
  count                       = 1
  tags = {
    name = "public_instance"
  }
}
resource "aws_instance" "private-instance" {
  ami                         = "ami-02a2af70a66af6dfb"
  associate_public_ip_address = ["${aws_security_group.aws_security_group_id}"]
  subnet_id                   = aws_subnet.private_subent.subnet_id
  instance_type               = "t2.micro"
  key_name                    = "devops"
  count                       = 1

  tags = {
    name = "private_instance"
  }
}


