provider "aws" {
  region = "${var.region}"
}

data "aws_caller_identity" "tfstate_current" {}

resource "aws_s3_bucket" "tfstate-bucket" {
  bucket = "tf-state-${data.aws_caller_identity.tfstate_current.account_id}"
  acl    = "private"
  tags = {
    Name = "terraform-remote-state-bucket"
  }
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "db-lock-table" {
  name           = "tflock-state-lock-${var.environment_name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

