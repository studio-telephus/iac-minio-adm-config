provider "minio" {
  minio_server   = var.provider_server
  minio_user     = var.minio_root_user
  minio_password = var.minio_root_password
  minio_ssl      = var.provider_ssl
}
