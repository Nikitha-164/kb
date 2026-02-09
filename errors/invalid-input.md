---
id: InvalidInputException
aliases:
  - invalidinputexception
  - invalid input
  - invalid job argument
  - invalid argument value
  - malformed s3 path
  - invalid s3 uri
  - path must start with s3://
  - unable to parse job arguments
  - invalid parameter value
scope: AWS::Glue::Job
category: CONFIG
severity: MEDIUM
---

# AWS Glue – Invalid Job Input / Configuration

## What happened
The Glue job failed because one or more job arguments or input paths
were invalid or malformed.

## Common causes
- S3 path missing `s3://`
- Extra or missing slashes in S3 URI
- Invalid job argument keys or values
- Unescaped characters in arguments

## Safe fixes
- Normalize S3 path format
- Replace invalid arguments with approved defaults