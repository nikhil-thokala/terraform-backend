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
      secret_id    = "4b94fc9a-b033-8ec4-3897-d763788ca8c4"
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