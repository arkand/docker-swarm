#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER kedai;
    CREATE DATABASE kedai;
    GRANT ALL PRIVILEGES ON DATABASE kedai TO kedai;
    CREATE DATABASE metabase;
    GRANT ALL PRIVILEGES ON DATABASE metabase TO kedai;
EOSQL