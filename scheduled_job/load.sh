#!/bin/bash

/usr/lib/oracle/19.3/client64/bin/sqlldr system/Oradoc_db1@db:1521/ORCLCDB.localdomain control=/app/things.ctl log=/app/sqlldr.log bad=/app/sqlldr.bad

cat /app/sqlldr.log
