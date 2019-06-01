#!/bin/bash

sleep 60

sqlplus -s /nolog <<EOF
  CONNECT system/Oradoc_db1@db:1521/ORCLCDB.localdomain
  ALTER SYSTEM SET archive_lag_target=0 scope=both;
  EXEC dbms_stats.init_package();

  DROP TABLE things_staging PURGE;
  CREATE TABLE things_staging ( id integer, thing varchar2(50) );

  DROP TABLE things PURGE;
  CREATE TABLE things ( id integer, thing varchar2(50) );

  QUIT
EOF