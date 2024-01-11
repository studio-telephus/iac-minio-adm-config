locals {
  bucket_platform_state_dev = "${var.state_bucket_prefix}platform-state-dev"
}

module "bucket_platform_state_dev" {
  source = "github.com/studio-telephus/terraform-minio-s3-bucket.git?ref=1.0.0"
  bucket = local.bucket_platform_state_dev
  versioning_configuration = {
    enabled = true
  }
}

data "minio_iam_policy_document" "bucket_platform_state_dev" {
  statement {
    sid    = "AllowOwnerToAll"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_platform_state_dev}",
      "arn:aws:s3:::${local.bucket_platform_state_dev}/*"
    ]
  }
}

resource "minio_iam_policy" "bucket_platform_state_dev" {
  name   = local.bucket_platform_state_dev
  policy = data.minio_iam_policy_document.bucket_platform_state_dev.json
}

resource "minio_iam_user_policy_attachment" "bucket_platform_state_dev" {
  user_name   = minio_iam_user.terraform_sa_user.id
  policy_name = minio_iam_policy.bucket_platform_state_dev.id
}