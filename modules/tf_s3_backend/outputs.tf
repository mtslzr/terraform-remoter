output "account_id" {
  value = "${data.aws_caller_identity.tfstate_current.account_id}"
}

output "backend_desc" {
  value = <<EOF
#

Add the following info into a .tf file in the same location as the working main.tf file.

Suggested action: terraform output terraform_config > ${var.environment_name}_backend.tf
EOF
}

output "terraform_config" {
  description = "Terraform excerpt with state backend configuration. Can be used in multi-environments terraform code."
  value = <<EOF
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.tfstate-bucket.id}"
    key            = "${var.environment_name}/${var.environment_name}-terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${aws_dynamodb_table.db-lock-table.id}"
    encrypt        = "true"
  }
}

# Environmental
variable "environment_name" { default = "${var.environment_name}" }

# Base_network
variable "region" { default = "${var.region}" }

EOF
}

output "bucket_name" {
  description = "S3 bucket name that has been created"
  value       = "${aws_s3_bucket.tfstate-bucket.id}"
}


