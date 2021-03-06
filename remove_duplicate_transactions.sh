#!/bin/bash
set -euo pipefail

# 1. delete duplicate A/497 contributions
cat <<-QUERY | psql disclosure-backend
DELETE FROM "efile_COAK_2016_497" late
USING "efile_COAK_2016_A-Contributions" contributions
WHERE contributions."Filer_ID"::varchar = late."Filer_ID"::varchar
AND (
  contributions."Tran_ID" = late."Tran_ID"
  OR (LOWER(contributions."Tran_NamL") = LOWER(late."Enty_NamL") AND contributions."Tran_Amt1" = late."Amount")
)
AND late."Form_Type" = 'F497P1';
QUERY

# 2. delete duplicate C/497 contributions
cat <<-QUERY | psql disclosure-backend
DELETE FROM "efile_COAK_2016_497" late
USING "efile_COAK_2016_C-Contributions" contributions
WHERE contributions."Filer_ID"::varchar = late."Filer_ID"::varchar
AND (
  contributions."Tran_ID" = late."Tran_ID"
  OR (LOWER(contributions."Tran_NamL") = LOWER(late."Enty_NamL") AND contributions."Tran_Amt1" = late."Amount")
)
AND late."Form_Type" = 'F497P1';
QUERY

# 3. delete duplicate E/497 expenditures
cat <<-QUERY | psql disclosure-backend
DELETE FROM "efile_COAK_2016_497" late
USING "efile_COAK_2016_E-Expenditure" expenditures
WHERE expenditures."Filer_ID"::varchar = late."Filer_ID"::varchar
AND (
  expenditures."Tran_ID" = late."Tran_ID"
  OR (LOWER(expenditures."Payee_NamL") = LOWER(late."Enty_NamL") AND expenditures."Amount" = late."Amount")
)
AND late."Form_Type" = 'F497P2';
QUERY
