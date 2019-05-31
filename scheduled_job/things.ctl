unrecoverable
load data
  infile '/app/things.data'
  into table things_staging
  fields terminated by ","
  ( id, thing )