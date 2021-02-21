terraform {
  backend "s3" {
    bucket = "foobar-user"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}