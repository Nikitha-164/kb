locals {
  region     = "ap-south-1"
  account_id = data.aws_caller_identity.current.account_id

  kb_name              = "resourceKB"
  kb_bucket            = "self-heal-kb-${local.account_id}-${local.region}"

 }