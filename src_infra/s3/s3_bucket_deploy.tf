resource "aws_s3_bucket" "lambdas_deploy" {
  bucket = "lambdas-alan"
  acl = "private"
}
