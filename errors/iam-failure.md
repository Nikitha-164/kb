---
id: IAMFailure
aliases:
  # Generic IAM denies seen in Glue jobs & crawlers
  - accessdeniedexception
  - access denied
  - not authorized to perform
  - is not authorized to perform
  - user is not authorized
  - the security token included in the request is invalid

  # S3 / KMS / Logs specifics often hit by Glue
  - s3 access denied
  - headobject operation: forbidden
  - kmsaccessdeniedexception
  - access denied for kms
  - logs:createloggroup access denied
  - logs:putlogevents access denied

  # iam:PassRole & role issues
  - is not authorized to perform iam:passrole
  - cannot assume role
  - unable to pass role
  - the service is not authorized to assume role

  # Minimal Glue service permissions missing
  - glue:getjob access denied
  - glue:getjobrun access denied
  - glue:getdatabase access denied
  - glue:gettable access denied
scope: AWS::Glue::Job
category: IAM
severity: HIGH
owner_team: platform-security
---

# AWS Glue – IAM Failure (Denied or Missing Permissions)

**What happened**  
Your Glue job failed due to **insufficient IAM permissions** on the execution role (S3/KMS/CloudWatch Logs/Glue APIs) or missing **`iam:PassRole`** during startup.

## Common symptoms (log snippets)
- `AccessDeniedException` or `Access denied` during S3/KMS/Logs/Glue calls  
- `User is not authorized to perform iam:PassRole` on the execution role  
- `glue:GetJob` / `glue:GetDatabase` / `glue:GetTable` → AccessDenied  
- CloudWatch logs not created: `logs:CreateLogGroup` / `logs:PutLogEvents` denied

## Likely causes
- S3 read/write not granted for the specific prefixes used by the job
- CloudWatch Logs permissions missing for log group/stream creation
- Role cannot be passed: missing `iam:PassRole` to the job’s execution role
- Minimal Glue runtime permissions not present (Get* calls)
- Policy drift or boundary/guardrails preventing access

## Safe fixes (governed by automation)
- **ADD_S3_READ** – grant `s3:GetObject` to the **required** input prefix only  
- **ADD_S3_WRITE** – grant `s3:PutObject` to the **required** output prefix only  
- **ADD_CLOUDWATCH_LOGS_WRITE** – allow `logs:CreateLogGroup|CreateLogStream|PutLogEvents`  
- **ADD_IAM_PASSROLE** – allow `iam:PassRole` for **this** execution role only  
- **ADD_GLUE_SERVICE_PERMISSIONS** – allow minimal Glue `Get*` APIs

> All fixes are scoped and respect hard guardrails (no wildcards, no trust‑policy changes, no admin/managed policies). High‑risk actions (e.g., PassRole) may require approval per automation policy.

## Operator tips
- Confirm the **exact** S3 prefixes (input/output/temp) used by this job and scope grants precisely.  
- If using KMS‑encrypted objects, ensure the role is allowed to **decrypt** with that KMS key and (if private networking) that KMS can be reached.  
- For `iam:PassRole`, the **caller** (Glue service) must be allowed to pass **this execution role** only (no `*`).