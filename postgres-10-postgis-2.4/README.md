# PostgreSQL-10-PostGIS-2.4

Installs _PostgreSQL 10_ and _PostGIS 2.4_ in an _Ubuntu 16.04_ box. IP address is `192.168.50.5` and SSH port is forwarded to `2020`. 

PostgreSQL can be reached from anywhere, `netstat -nlt`:

```
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:5432            0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 :::5432                 :::*                    LISTEN
```

Two roles are created: `ddluser` and `dmluser`. "Nomen est omen": `ddluser` should be used for `ddl` statements in the automatically created database `sogis` (which he owns). The `dmluser` should be used for `dml` statements.

Tested with an _ili2pg_ import from the host (macOS):

`java -jar Apps/ili2pg-3.9.1/ili2pg.jar --dbhost 192.168.50.5 --dbport 5432 --dbdatabase sogis --dbusr ddluser --dbpwd ddluser --nameByTopic --disableValidation --sqlEnableNull --createGeomIdx --createFkIdx --createFk --models SO_Nutzungsplanung_20170915 --dbschema npl_wisen --import Downloads/exp1_wis_20170926_umbau.xtf`

Data can be accessed with _dbeaver_ from the host and with _QGIS_ from another vagrant box. The `dmluser` cannot access the data since he has no permissions yet for this schema and the tables.

