# Anleitung Vagrant-Maschine mit PostgreSQL 9.2 PostGIS 1.5 

Maschine starten, PostgreSQL und PostGIS installieren und DB _sogis_ anlegen:
```
vagrant up
vagrant ssh
sudo -u postgres createdb sogis
sudo -u postgres psql -d sogis -f /usr/share/postgresql/9.2/contrib/postgis-1.5/postgis.sql
sudo -u postgres psql -d sogis -f /usr/share/postgresql/9.2/contrib/postgis-1.5/spatial_ref_sys.sql
sudo -u postgres psql -d sogis -c "create extension \"uuid-ossp\";"
```

DB-Dump verfügbar machen:
```
sudo apt-get install sshfs
sudo mkdir /mnt/workspace
sudo sshfs -o allow_other,default_permissions USER@SERVER:/opt/workspace /mnt/workspace/
```

Restoren eines Schemas aus einem Dump:
```
sudo -u postgres psql -d sogis -c "create schema awjf_wegsanierungen;"
sudo -u postgres pg_restore -d sogis --single-transaction -O -x --schema awjf_wegsanierungen /mnt/workspace/dbdumb/sogis.dmp
sudo -u postgres psql -d sogis -c "create user USER;"
sudo -u postgres psql -d sogis -c "grant usage on schema awjf_wegsanierungen to USER; grant select on all tables in schema awjf_wegsanierungen to USER;"
```
