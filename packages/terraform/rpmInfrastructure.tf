provider "aws" {
  profile = "default"
  region = "us-east-2"
}

resource "aws_s3_bucket" "rpm-bucket" {
  bucket = "serena-minecraft-rpm-bucket"
  acl    = "private"
  website {
    index_document = "index.html"
  }

  tags = {
    Name        = "rpm-bucket"
    Purpose = "minecraft server"
    ManagedByTerraform = "true"
    Environment = "Dev"
  }
}
