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

## Docker


> sudo docker build . -t "demokratis-db:0.1"

or 

> sudo docker build . -t "demokratis-db:0.1" -f Dockerfile_fakedata

> sudo docker run --name demokratisdb -p 5432:5432 -it demokratis-db:0.1

OR if you're already running postgres on port 5432, then

> sudo docker run --name demokratisdb -p 9999:5432 -it demokratis-db:0.1

OR

> sudo docker run --name SOME_OTHER_NAME -p 9999:5432 -it demokratis-db:0.1


## Connect 

> sudo -u postgres psql -h localhost -p 9999 -U docker demokratis
 
> password: post123

> \l

> \q