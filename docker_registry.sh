#!/usr/bin/env bash

docker stop socat-registry; docker rm socat-registry
docker build -t socat-registry -f applications/socat/Dockerfile applications/socat
docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400"  --name socat-registry -p 30400:5000 socat-registry