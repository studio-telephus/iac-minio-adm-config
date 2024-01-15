variable "minio_server" {
  type    = string
  default = "minio.adm.acme.corp:9000"
}

variable "minio_ssl" {
  type    = bool
  default = true
}

variable "state_bucket_prefix" {
  type    = string
  default = "bucket-"
}
