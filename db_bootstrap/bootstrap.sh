#!/bin/bash

sleep 60

sqlplus -s /nolog <<EOF
  connect system/Oradoc_db1@db:1521/ORCLCDB.localdomain
  alter system set archive_lag_target=0 scope=both;
  drop table things_staging PURGE;
  create table things_staging ( id integer, thing varchar2(50) );
  create table things ( id integer, thing varchar2(50) );
  quit
EOF