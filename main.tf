terraform {
  # Enforce version of Terraform
  required_version = "0.12.14"
}

provider "aws" {
  region = "eu-west-1"

  # Enforce version of AWS provider
  version = "2.43.0"
}

resource "aws_instance" "minimalVM" {
  ami           = "ami-db1688a2"
  instance_type = "t2.nano"
}