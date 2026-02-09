---
id: S3NoSuchKey
aliases:
  - nosuchkey
  - the specified key does not exist
  - the specified key does not exist.
  - no such key
  - 404 not found (headobject)
  - s3 prefix not found
  - path does not exist: s3://
  - file not found in s3
  - glue input path does not exist
  - partition not found at s3
scope: AWS::Glue::Job
category: S3
severity: MEDIUM
---

# S3: NoSuchKey (Path or Prefix Not Found)

**Symptom (typical logs)**
- `botocore.exceptions.ClientError: An error occurred (404) when calling the HeadObject operation: Not Found`
- `NoSuchKey: The specified key does not exist`
- `Path does not exist: s3://bucket/prefix/…`
- `Unable to read input location s3://…` (Glue job/crawler)

**Common causes**
- Input not yet landed / late-arriving partition
- Typo in bucket/prefix/file name
- Wrong partition path for the processing date

**Fix**
1. Verify the exact S3 path used by the job argument (bucket, prefix, full key).
2. If using date partitions, check the computed partition for the run time.
3. Update the job argument to an existing prefix/key (see automation policy).

**Automation (safe)**
- **Fix ID**: `UPDATE_S3_INPUT_PATH` — update job’s input path to a valid prefix discovered from policy checks.