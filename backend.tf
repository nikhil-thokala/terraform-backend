terraform {
  backend "s3" {
    bucket = "terraform-state1226"
    region = "us-east-1"
    key    = "terraform/terraform.tfstate"
    
  }
}