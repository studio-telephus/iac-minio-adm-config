locals {
  bucket_platform_state_snb = "${var.state_bucket_prefix}platform-state-snb"
}

module "bucket_platform_state_snb" {
  source = "github.com/studio-telephus/terraform-minio-s3-bucket.git?ref=1.0.0"
  bucket = local.bucket_platform_state_snb
  versioning_configuration = {
    enabled = true
  }
}

data "minio_iam_policy_document" "bucket_platform_state_snb" {
  statement {
    sid    = "AllowOwnerToAll"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_platform_state_snb}",
      "arn:aws:s3:::${local.bucket_platform_state_snb}/*"
    ]
  }
}

resource "minio_iam_policy" "bucket_platform_state_snb" {
  name   = local.bucket_platform_state_snb
  policy = data.minio_iam_policy_document.bucket_platform_state_snb.json
}

resource "minio_iam_user_policy_attachment" "bucket_platform_state_snb" {
  user_name   = minio_iam_user.minio_user_platform.id
  policy_name = minio_iam_policy.bucket_platform_state_snb.id
}