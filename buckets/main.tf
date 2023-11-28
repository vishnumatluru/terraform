 provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "example-vishnu" {
  bucket = "my-vishnu-bucket"

  tags = {
    Name        = "My-bucket-vishnu"
    Environment = "Dev"
  }
}