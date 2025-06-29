terraform {
  backend "s3" {
    bucket         = "terraform-state-snapcast"
    key            = "eks/state-file/terraform.tfstate"
    region         = "us-east-1"
  }
}