terraform {
  backend "s3" {
    bucket = "buck777anw"
    key    = "path/key"
    region = "us-east-1"
  }
}
