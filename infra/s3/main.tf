provider "aws" {
  region = "us-east-1"
  profile = "learn-sqs"
}

resource "aws_s3_bucket" "deploy" {
  bucket = "lambdas-alan"
  acl = "private"
}
