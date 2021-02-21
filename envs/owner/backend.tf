terraform {
  backend "s3" {
    bucket = "foobar-owner"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}