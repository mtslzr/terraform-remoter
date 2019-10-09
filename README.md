# Terraform Remoter

Simple module to convert a new or existing Terraform setup into using a remote S3 state and Dynamo lock table.

## Getting Started

Download the repo, and copy both folders (`deploy_s3_backend` and `modules`) into your working Terraform directory:

```bash
git clone git@github.com:mtslzr/terraform-remoter
cp -R terraform-remoter/{deploy_s3_backend,modules} /path/to/my/terraform/
cd /path/to/my/terraform/
```

## Usage

_All commands should be run with aws-vault or other AWS credentials for the account to which you plan to deploy._

```bash
cd deploy_s3_backend
terraform init
terraform apply
```

This will initialize the backend and create an S3 bucket and Dynamo lock table. After it completes, run `terraform output`. From the output, copy the backend section:

```bash
terraform {
  backend "s3" {
    bucket         = "<BUCKETNAMEHERE>"
    key            = "dev/dev-terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tflock-state-lock-dev"
    encrypt        = "true"
  }
}
```

Paste this into your `main.tf` file, and (re-)run `terraform init` in your main Terraform directory.

```bash
cd ..
terraform init
```

If you've made local state changes, you'll be prompted to copy them to S3. Enter `yes` to do so, or `no` if starting fresh.

Confirm that the `terraform.tfstate` file in your main folder is now zero bytes, and that `terraform plan` or `terraform apply` return the expected output.

### .gitignore

Make sure to add the following entries to your `.gitignore` file before committing the changes:

```
.terraform
*.tfstate*
```
