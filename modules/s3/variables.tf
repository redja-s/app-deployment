variable "logging_bucket_name" {
    type = string
    description = "Name of S3 bucket that stores logs"
}

variable "logging_bucket_versioning" {
    type = bool
    description = "Whether versioning should be enabled - T/F"
}