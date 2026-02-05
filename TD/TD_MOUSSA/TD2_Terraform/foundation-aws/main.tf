resource "aws_s3_bucket" "bucket_td2" {
  bucket = var.bucket_name
  acl    = "private"
}
