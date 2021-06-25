resource "aws_s3_bucket" "deploy" {
  bucket = "lambdas-alan"
  acl = "private"
}
