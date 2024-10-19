provider "aws" {
    region = "us-east-1"
}

provider "vault" {
  address          = "http://54.89.167.92:8200"
  skip_child_token = true

  auth_login {
    path           = "auth/approle/login"

    parameters = {
      role_id      = "c5a166a3-f0bf-5081-20b4-525093e57ca1"
      secret_id    = "a12990f8e-79e5-078f-dc74-fb9a53dc9031"
    }
  }

}

data "vault_kv_secret_v2" "example" {
  mount = "kv" 
  name  = "test" 
}


resource "aws_instance" "example" {
    ami             = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    subnet_id       = "subnet-031cdd8f64c419076"
    key_name        = "DevOps" 

tags = {
    Name = backend-init-valutinit
    secret = data.vault_kv_secret_v2.example.data["username"]
  }
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket          = "terraform-state1226" 
}

/*
resource "aws_dynamodb_table" "terrform_lock" {
    name         = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}
*/