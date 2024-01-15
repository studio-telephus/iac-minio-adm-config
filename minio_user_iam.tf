resource "minio_iam_user" "minio_user_iam" {
  name   = module.minio_user_iam.data.username
  secret = module.minio_user_iam.data.password
}

resource "minio_iam_service_account" "minio_user_iam" {
  target_user = minio_iam_user.minio_user_iam.name
}

resource "local_file" "minio_user_iam_access_key" {
  sensitive_content = minio_iam_service_account.minio_user_iam.access_key
  filename          = ".terraform/minio_user_iam_access_key.out"
}

resource "local_file" "minio_user_iam_secret_key" {
  sensitive_content = minio_iam_service_account.minio_user_iam.secret_key
  filename          = ".terraform/minio_user_iam_secret_key.out"
}