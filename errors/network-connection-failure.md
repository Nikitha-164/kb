---
id: NetworkConnectionFailure
aliases:
  - connection timed out
  - connect timed out
  - connection refused
  - could not connect to jdbc endpoint
  - unable to reach database
  - endpoint unreachable
  - no route to host
  - connection reset by peer
  - failed to establish jdbc connection
  - test connection failed
  - glue job failed to connect
scope: AWS::Glue::Job
category: NETWORK
severity: MEDIUM
---

# AWS Glue – Network Connection Failure

## What happened
The Glue job could not reach the target system due to missing or incorrect
network or connection configuration.

## Common causes
- Glue connection not attached to the job
- Job running in wrong VPC or subnet
- Security group blocks outbound or inbound traffic
- Wrong hostname or port in JDBC URL

## Safe fixes
- Attach a pre‑approved Glue connection
- Align job VPC/subnet/SG with the connection profile
- Verify endpoint and port reachability