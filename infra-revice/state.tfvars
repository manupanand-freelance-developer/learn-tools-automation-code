 
terraform {
  backend "s3" {
    # leave empty comes from each env state-files
    bucket = "dev-ops-state-manupa"
    key    = "server/tools.tfstate"
    region = "ap-south-1"
  }
}