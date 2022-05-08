#!/bin/bash

sudo apt update
sudo snap install docker
sudo addgroup --system docker
sudo adduser ubuntu docker
newgrp docker
sudo snap disable docker
sudo snap enable docker

sudo su - ubuntu -c "docker run -d -p ${host_port}:${container_port} \
    --name ${container_name} ${image}"  