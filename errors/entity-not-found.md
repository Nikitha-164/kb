---
id: EntityNotFoundException
aliases:
  - entitynotfoundexception
  - entity not found
  - database not found
  - table not found
  - glue database does not exist
  - glue table does not exist
  - connection not found
  - unable to verify existence of database
  - getcatalogsource .* entity not found
scope: AWS::Glue::Job
category: GLUE
severity: MEDIUM
---

# AWS Glue – Referenced Resource Not Found

## What happened
The Glue job referenced a Glue resource that does not exist:
- Database
- Table metadata
- Glue connection

## Common causes
- Database or table not created yet
- Metadata deleted or renamed
- Job deployed before catalog setup
- Connection missing from account/region

## Safe fixes (governed)
- Create missing Glue database (if expected)
- Create table metadata (without inferring schema)
- Attach an existing, approved Glue connection