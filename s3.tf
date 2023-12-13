
resource "aws_s3_bucket_acl" "main" {
  bucket     = aws_s3_bucket.main.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.main.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  redirect_all_requests_to {
    host_name = var.redirect_target
  }
}


resource "aws_s3_bucket" "main" {
  provider = aws.main
  bucket   = var.fqdn

  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      "Name" = var.fqdn
    },
  )
}
