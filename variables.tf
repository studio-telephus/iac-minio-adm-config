variable "provider_server" {
  type = string
  default = "minio.adm.acme.corp:9000"
}

variable "provider_ssl" {
  type    = bool
  default = true
}

variable "minio_root_user" {
  type = string
  default = "minio-admin"
  sensitive = true
}

variable "minio_root_password" {
  type      = string
  sensitive = true
}

variable "minio_terraform_sa_username" {
  type    = string
  default = "sa-minio-terraform"
  sensitive = true
}

variable "minio_terraform_sa_secret" {
  type      = string
  sensitive = true
}