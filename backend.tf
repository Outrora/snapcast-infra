terraform {
  backend "s3" {
    bucket         = "terraform-snapcast1"
    key            = "eks/state-file/terraform.tfstate"
    region         = "us-east-1"
  }
}