resource "minio_iam_user" "minio_user_platform" {
  name   = module.minio_user_platform.data.username
  secret = module.minio_user_platform.data.password
}

resource "minio_iam_service_account" "minio_user_platform" {
  target_user = minio_iam_user.minio_user_platform.name
  lifecycle {
    ignore_changes = [policy]
  }
}

resource "local_sensitive_file" "minio_user_platform_access_key" {
  content = minio_iam_service_account.minio_user_platform.access_key
  filename          = ".terraform/minio_user_platform_access_key.out"
}

resource "local_sensitive_file" "minio_user_platform_secret_key" {
  content = minio_iam_service_account.minio_user_platform.secret_key
  filename          = ".terraform/minio_user_platform_secret_key.out"
}