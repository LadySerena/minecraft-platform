provider "aws" {
    region = "us-east-2"
    profile = "default"
}

resource "aws_s3_bucket" "deb-bucket" {
  bucket = "serena-deb-bucket"
  acl = "private"
  tags = {
    Purpose = "minecraft"
    ManagedByTerraform = "true"
  }
}
