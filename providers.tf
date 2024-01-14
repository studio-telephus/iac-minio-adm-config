provider "minio" {
  minio_server   = var.minio_server
  minio_user     = module.minio_root_user.data.username
  minio_password = module.minio_root_user.data.password
  minio_ssl      = var.minio_ssl
}
