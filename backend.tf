terraform {
  backend "s3" {
    bucket = "anastasiyaohaltestbuckets3"
    key    = "path/key"
    region = "us-east-1"
  }
}
