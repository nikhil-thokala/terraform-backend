provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami             = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    subnet_id       = "subnet-031cdd8f64c419076"
    key_name        = "DevOps" 

tags = {
    Name = "backend-init"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket          = "terraform-state1226" 
}