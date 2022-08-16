terraform {
  backend "s3" {
    bucket = var.s3bucket  #Backend s3 bucket name
    key = var.s3bucketkey
    region = var.s3bucketregion # Backend S3 bucket region
    # dynamodb_table = "tablename" # Used for state locking
  }
}