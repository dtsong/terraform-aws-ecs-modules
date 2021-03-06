resource "aws_s3_bucket" "main" {
  bucket = var.name
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}
