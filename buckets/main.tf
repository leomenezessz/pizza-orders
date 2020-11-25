resource "aws_s3_bucket" "this" {
  bucket = "${var.name}"
  acl    = "${var.acl}"
}

resource "aws_s3_bucket_object" "this" {
  bucket = "${aws_s3_bucket.this.id}"
  key    = "${var.local_file}"
  source = "${var.destiny_file}"
}
