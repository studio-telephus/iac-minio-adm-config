module "minio_root_user" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "4f1dc27c-2bbe-4856-b4f4-b0f700648062"
}

module "minio_user_platform" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "a5eee3a8-8637-45d8-8828-b0f700651f94"
}

module "minio_user_iam" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "f0b0f5be-ac60-480a-9fec-b0f500e27418"
}
