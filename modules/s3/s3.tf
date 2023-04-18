resource "aws_s3_bucket" "logging_bucket" {
    bucket_prefix = var.logging_bucket_name
}

resource "aws_s3_bucket_versioning" "logging_bucket_versioning" {
    count = var.logging_bucket_versioning == true ? 1 : 0
    bucket = aws_s3_bucket.logging_bucket.bucket
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "logging_bucket_lifecycle" {
    bucket = aws_s3_bucket.logging_bucket.bucket
    
    rule {
        id = "transition-to-standard-ia"
        status = "Enabled"
        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }
    }
}