terraform {
  backend "s3" {}
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "~> 2.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "~> 0.7"
    }
  }
}
