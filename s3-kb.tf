resource "aws_s3_bucket" "kb" {
  bucket = local.kb_bucket
  
  tags = { Name = local.kb_bucket, Purpose = "Bedrock-KB-Source" }
}

resource "aws_s3_bucket_public_access_block" "kb" {
  bucket                  = aws_s3_bucket.kb.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "kb" {
  bucket = aws_s3_bucket.kb.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "kb" {
  bucket = aws_s3_bucket.kb.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # <-- NO KMS
    }
  }
}

resource "aws_s3_bucket_policy" "kb_tls" {
  bucket = aws_s3_bucket.kb.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "DenyInsecureTransport",
      Effect    = "Deny",
      Principal = "*",
      Action    = "s3:*",
      Resource  = [aws_s3_bucket.kb.arn, "${aws_s3_bucket.kb.arn}/*"],
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

########################################
# Upload ALL KB error files from ./errors
########################################
resource "aws_s3_object" "kb_errors" {
  for_each = fileset("${path.module}/errors", "*.yaml")

  bucket       = aws_s3_bucket.kb.id
  key          = "errors/${each.value}"                    # S3 path
  content      = file("${path.module}/errors/${each.value}")
  content_type = "application/yaml"

  depends_on = [
    aws_s3_bucket.kb,
    aws_s3_bucket_public_access_block.kb,
    aws_s3_bucket_versioning.kb,
    aws_s3_bucket_server_side_encryption_configuration.kb,
    aws_s3_bucket_policy.kb_tls
  ]
}