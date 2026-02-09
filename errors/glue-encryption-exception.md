---
id: GlueEncryptionException
aliases:
  - glueencryptionexception
  - encryption operation failed
  - kmsaccessdeniedexception
  - not authorized to use kms key
  - cannot decrypt data key
  - failed to encrypt data
  - s3 access denied due to encryption
  - bucket enforces kms encryption
  - encryption configuration mismatch
scope: AWS::Glue::Job
category: ENCRYPTION
severity: HIGH
---

# AWS Glue – Encryption Configuration Failure

## What happened
The Glue job failed because encryption settings between Glue, Amazon S3,
and AWS KMS are incompatible or misconfigured.

## Common causes
- Output bucket enforces KMS encryption, but Glue role lacks key permissions
- Glue job uses a KMS key it cannot encrypt/decrypt with
- Mismatch between job encryption config and bucket encryption policy

## Safe fixes (controlled)
- Align Glue job encryption settings with bucket/KMS configuration
- Grant **kms:Decrypt** permission for encrypted inputs (scoped to key)

> ⚠️ Changes to encryption configuration are **high‑risk** and require approval.