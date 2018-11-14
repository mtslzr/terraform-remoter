
module "tf_backend" {
  source = "../modules/tf_s3_backend"
  environment_name = "${var.environment_name}"
  region = "${var.region}"
}

data "aws_caller_identity" "testing_current" {}


