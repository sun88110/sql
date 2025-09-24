select username from all_users;

ALTER SESSION SET "_ORACLE_SCRIPT"=true;

create user scott
identified by tiger
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE
TO  scott;