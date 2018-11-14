output "account_id" {
  value = "${data.aws_caller_identity.testing_current.account_id}"
}

output "bucket_name" {
  value = "${module.tf_backend.bucket_name}"
}

output "config_description" {
  value = "${module.tf_backend.backend_desc}"
}

output "terraform_config" {
  value = "${module.tf_backend.terraform_config}"
}
