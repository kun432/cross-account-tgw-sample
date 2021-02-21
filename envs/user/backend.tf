terraform {
  backend "s3" {
    bucket = "cross-account-tgw-user"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}