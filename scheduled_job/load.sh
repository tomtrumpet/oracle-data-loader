#!/bin/bash

echo "Truncate any existing staging data before loading data from disk"
sqlplus -s /nolog <<EOF
  CONNECT system/Oradoc_db1@db:1521/ORCLCDB.localdomain
  TRUNCATE TABLE things_staging;
  QUIT
EOF

echo "SQL*Loader loading from disk into staging table"
/usr/lib/oracle/19.3/client64/bin/sqlldr system/Oradoc_db1@db:1521/ORCLCDB.localdomain direct=true control=/app/things.ctl log=/app/sqlldr.log bad=/app/sqlldr.bad

echo "SQL*Loader logs"
cat /app/sqlldr.log

echo "Load staging table into live table"

# Keeping for reference, an approach quicker than traditional inserts, but not as quick as insert /*+ append */

# DECLARE
#     TYPE t IS TABLE OF things_staging%ROWTYPE;
#     things_temp t := t();
#   BEGIN
#     SELECT * BULK COLLECT INTO things_temp FROM things_staging;
  
#     FORALL i in things_temp.first .. things_temp.last
#       INSERT INTO things VALUES things_temp(i);
#       COMMIT;
#   END;
#   /

sqlplus -s system/Oradoc_db1@db:1521/ORCLCDB.localdomain <<EOF
  SET TIMING ON;

  INSERT /*+ APPEND */
  INTO things (id, thing)
  SELECT id, thing
  FROM things_staging;
  COMMIT;
  
  SELECT COUNT(*) FROM things;
  
  SET TIMING OFF;
  QUIT
EOF

echo "Completed loading staging table into live table"
