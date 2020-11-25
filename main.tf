provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials}"
  profile                 = "${var.profile}"
}

module "terraform_test_bucket" {
  source = "./buckets"
  name = "terraform-test-bucket-leomenezessz"
  local_file = "hey-this-is-really-beautiful.txt"
  destiny_file = "file/my-beautiful-file.txt"
} 

module "ec2" {
  source = "./ec2"
  tags = {
    Name = "EC2-Terraform-Test"
  }
}

