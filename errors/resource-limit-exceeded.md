---
id: ResourceLimitExceeded
aliases:
  - resourcelimitexceededexception
  - exceeded configured resources
  - dpu limit exceeded
  - job exceeded maximum capacity
  - job exceeded allocated capacity
  - executor lost due to memory pressure
  - out of memory error
  - container killed by yarn
  - job timed out
  - execution timed out
  - spark stage failed due to memory
scope: AWS::Glue::Job
category: LIMITS
severity: HIGH
---

# AWS Glue – Resource Limit Exceeded

## What happened
The Glue job exceeded allocated resources such as:
- DPUs
- Memory
- Execution timeout

## Common causes
- Under‑provisioned DPUs
- Large data volume
- Memory‑heavy transformations
- Long‑running stages

## Safe fixes
- Increase DPUs (within approved ceiling)
- Increase job timeout
- Optimize transformations
- Reduce shuffle / repartition data