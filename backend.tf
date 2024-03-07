terraform {
  backend "s3" {
    bucket = "mybuck2332"
    key    = "path/key"
    region = "us-east-1"
  }
}
