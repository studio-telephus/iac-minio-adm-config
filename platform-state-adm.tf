locals {
  bucket_platform_state_adm = "${var.state_bucket_prefix}platform-state-adm"
}

module "bucket_platform_state_adm" {
  source = "github.com/studio-telephus/terraform-minio-s3-bucket.git?ref=1.0.0"
  bucket = local.bucket_platform_state_adm
  versioning_configuration = {
    enabled = true
  }
}

data "minio_iam_policy_document" "bucket_platform_state_adm" {
  statement {
    sid    = "AllowOwnerToAll"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_platform_state_adm}",
      "arn:aws:s3:::${local.bucket_platform_state_adm}/*"
    ]
  }
}

resource "minio_iam_policy" "bucket_platform_state_adm" {
  name   = local.bucket_platform_state_adm
  policy = data.minio_iam_policy_document.bucket_platform_state_adm.json
}

resource "minio_iam_user_policy_attachment" "bucket_platform_state_adm" {
  user_name   = minio_iam_user.minio_user_platform.id
  policy_name = minio_iam_policy.bucket_platform_state_adm.id
}