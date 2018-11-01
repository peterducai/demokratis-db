# demokratis-db
db for demokratis


## PG DEBIAN/UBUNTU
```
sudo apt-get install postgresql postgresql-contrib
/usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start
```

## PG RHEL/CENTOS

```
sudo yum install postgresql-server postgresql-contrib
sudo postgresql-setup initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql

sudo firewall-cmd --permanent --zone=trusted --add-port=5432/tcp
sudo firewall-cmd --reload
```

## psql set password

```
sudo -u postgres psql
\password

\q
```



> sudo systemctl enable postgresql

> sudo systemctl restart postgresql