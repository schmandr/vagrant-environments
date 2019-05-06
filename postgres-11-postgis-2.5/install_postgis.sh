#!/bin/bash

# Install PostgreSQL and PostGIS
curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt-get update
apt-get install -y postgresql-11
apt-get install -y postgresql-client-11
apt-get install -y postgresql-11-postgis-2.5

# Configure PostgreSQL
cp /vagrant/pg_hba.conf /etc/postgresql/11/main
echo "listen_addresses = '*'" > /etc/postgresql/11/main/conf.d/development.conf
chown postgres: /etc/postgresql/11/main/conf.d/development.conf
service postgresql restart

# Create database roles and PostGIS database
dbname=geodb
sudo -u postgres psql -d postgres -c "CREATE ROLE ddluser LOGIN PASSWORD 'ddluser';"
sudo -u postgres psql -d postgres -c "CREATE ROLE dmluser LOGIN PASSWORD 'dmluser';"
sudo -u postgres psql -d postgres -c "CREATE DATABASE $dbname OWNER ddluser;"
sudo -u postgres psql -d $dbname  -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d $dbname  -c "CREATE EXTENSION \"uuid-ossp\";"
