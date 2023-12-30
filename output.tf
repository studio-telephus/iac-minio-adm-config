output "terraform_sa_access_key" {
  value     = minio_iam_service_account.terraform_sa.access_key
  sensitive = true
}

output "terraform_sa_secret_key" {
  value     = minio_iam_service_account.terraform_sa.secret_key
  sensitive = true
}