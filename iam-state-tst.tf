locals {
  bucket_iam_state_tst = "iam-state-tst"
}

module "bucket_iam_state_tst" {
  source = "github.com/studio-telephus/terraform-minio-s3-bucket.git?ref=1.0.0"
  bucket = local.bucket_iam_state_tst
  versioning_configuration = {
    enabled = true
  }
}

data "minio_iam_policy_document" "bucket_iam_state_tst" {
  statement {
    sid    = "AllowOwnerToAll"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.bucket_iam_state_tst}",
      "arn:aws:s3:::${local.bucket_iam_state_tst}/*"
    ]
  }
}

resource "minio_iam_policy" "bucket_iam_state_tst" {
  name   = local.bucket_iam_state_tst
  policy = data.minio_iam_policy_document.bucket_iam_state_tst.json
}

resource "minio_iam_user_policy_attachment" "bucket_iam_state_tst" {
  user_name   = minio_iam_user.terraform_sa_user.id
  policy_name = minio_iam_policy.bucket_iam_state_tst.id
}