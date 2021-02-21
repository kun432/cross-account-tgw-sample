terraform {
  backend "s3" {
    bucket = "cross-account-tgw-owner"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}