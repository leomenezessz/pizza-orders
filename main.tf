provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials}"
  profile                 = "${var.profile}"
}

resource "aws_s3_bucket" "test-bucket" {
  bucket = "terraform-bucket-leomenezessz"
  acl    = "private"

  tags = {
    Name        = "Leo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.test-bucket.id}"
  key    = "hey-this-is-really-beautiful.txt"
  source = "file/my-beautiful-file.txt"
}