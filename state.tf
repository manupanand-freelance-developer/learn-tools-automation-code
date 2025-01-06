terraform {
  backend "s3" {
    bucket = "bucket-name"
    key = "tool/terraform.tfstate"
    region = "ap-south-1"
  }
}