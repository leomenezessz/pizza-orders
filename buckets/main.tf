resource "aws_s3_bucket" "this" {
  bucket = "${var.name}"
  acl    = "${var.acl}"
  versioning {
    enabled = "${var.versioning}"
  }
}

resource "aws_s3_bucket_object" "this" {
  count  = "${var.create_object ? 1 : 0}"

  bucket = "${aws_s3_bucket.this.id}"
  key    = "${var.key}"
  source = "${var.source_file}"
  etag   = "${filemd5("${var.source_file}")}"
}
