---
id: AccessDeniedException
aliases:
  - accessdeniedexception
  - access denied
  - user is not authorized
  - not authorized to perform
  - is not authorized to perform
  - s3 access denied
  - headobject operation: forbidden
  - kmsaccessdeniedexception
  - not authorized to use kms key
scope: AWS::Glue::Job
category: IAM
severity: HIGH
---

# AWS Glue – Access Denied (IAM)

## What happened
The Glue job failed because the execution role does not have sufficient
IAM permissions to access required AWS resources.

## Common causes
- Missing S3 read permissions on input paths
- Missing KMS decrypt permission on encrypted objects
- IAM policy drift or partial role configuration

## Safe fixes (controlled)
- Grant scoped **S3 read** access to required prefix
- Grant scoped **KMS decrypt** permission to required key

> ⚠️ IAM changes are sensitive and must follow least‑privilege rules.