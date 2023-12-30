locals {
  buckets = [
    "iam-state-dev",
    "iam-state-tst",
    "platform-state-adm",
    "platform-state-dev",
    "platform-state-tst"
  ]
}

resource "minio_iam_user" "terraform_sa_user" {
  name   = var.minio_terraform_sa_username
  secret = var.minio_terraform_sa_password
}

resource "minio_iam_service_account" "terraform_sa" {
  target_user = minio_iam_user.terraform_sa_user.name
}

resource "local_file" "terraform_sa_access_key" {
  content    = minio_iam_service_account.terraform_sa.access_key
  filename   = var.path_terraform_sa_access_key
  depends_on = [minio_iam_service_account.terraform_sa]
}

resource "local_file" "terraform_sa_secret_key" {
  content    = minio_iam_service_account.terraform_sa.secret_key
  filename   = var.path_terraform_sa_secret_key
  depends_on = [minio_iam_service_account.terraform_sa]
}