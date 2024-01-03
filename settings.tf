terraform {
  backend "s3" {}
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "~> 2.0"
    }
  }
}
