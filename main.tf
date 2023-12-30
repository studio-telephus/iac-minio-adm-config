locals {
  bucket_name = "tfstate-adm"
}

module "tfstate_adm_bucket" {
  source = "github.com/studio-telephus/terraform-minio-s3-bucket.git?ref=main"
  bucket = "tfstate-adm"
  versioning_configuration = {
    enabled = true
  }
}

data "minio_iam_policy_document" "rw_policy" {
  statement {
    sid    = "AllowOwnerToAll"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_name}",
      "arn:aws:s3:::${local.bucket_name}/*"
    ]
  }
}

resource "minio_iam_policy" "rw_policy" {
  name   = local.bucket_name
  policy = data.minio_iam_policy_document.rw_policy.json
}

resource "minio_iam_user" "terraform_sa_user" {
  name   = var.minio_terraform_sa_username
  secret = var.minio_terraform_sa_secret
}

resource "minio_iam_user_policy_attachment" "terraform_sa_user_policy" {
  user_name   = minio_iam_user.terraform_sa_user.id
  policy_name = minio_iam_policy.rw_policy.id
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