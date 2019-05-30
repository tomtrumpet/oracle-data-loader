#!/bin/bash

sqlplus -s /nolog <<EOF
  connect system/Oradoc_db1@db:1521/ORCLCDB.localdomain
  create table things_staging ( id integer, thing varchar2(20) );
  delete from things_staging;
  quit
EOF

/usr/lib/oracle/19.3/client64/bin/sqlldr system/Oradoc_db1@db:1521/ORCLCDB.localdomain control=/app/things.ctl log=/app/sqlldr.log bad=/app/sqlldr.bad

cat /app/sqlldr.log
