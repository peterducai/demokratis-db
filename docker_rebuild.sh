#!/bin/bash
#docker pull peterducai/demokratis-db:latest  
sudo docker stop demokratis-db1  
sudo docker rm demokratis-db1   
sudo docker rmi peterducai/demokratis-db:v0.0.1
sudo docker rm `docker ps --no-trunc -aq` 
sudo docker images -q --filter "dangling=true" | xargs docker rmi  
sudo docker build . -t "peterducai/demokratis-db:v0.0.1" -f Dockerfile_fakedata 
sudo docker tag peterducai/demokratis-db:v0.0.1  peterducai/demokratis-db:latest
sudo docker run -d --name demokratis-db1 -p 9999:5432 peterducai/demokratis-db:latest  
sudo docker ps -a
sleep 5
sudo docker logs demokratis-db1