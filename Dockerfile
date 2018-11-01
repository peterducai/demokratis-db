FROM postgres

ENV POSTGRES_USER docker
ENV POSTGRES_PASSWORD post123

COPY demokratis_db_docker.sql /docker-entrypoint-initdb.d/demokratis_db_docker.sql

 #will be executed automatically

