provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials}"
  profile                 = "${var.profile}"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-leomenezessz"
    key = "main/tf.tfstate"
    region = "us-east-1"
  }
}

module "terraform_test_bucket" {
  source       = "./buckets"
  name         = "terraform-test-bucket-leomenezessz"
  create_object = true
  versioning = true
  key = "hey-this-is-really-beautiful.txt"
  source_file   = "file/my-beautiful-file.txt"
}

module "terraform_state" {
  source       = "./buckets"
  name         = "terraform-state-leomenezessz"
  versioning = true
}

module "ec2" {
  source = "./ec2"

  tags = {
    Name = "EC2-Terraform-Test"
  }
}
