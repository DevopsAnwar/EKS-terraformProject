terraform {
  backend "s3" {
    bucket = "anwarbucket77777"
    key    = "path/key"
    region = "us-east-1"
  }
}
