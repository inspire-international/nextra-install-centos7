#!/bin/sh

CONTAINER_NAME=nextra

sudo docker start $CONTAINER_NAME

# Run broker and rpcjava 2 samples
sudo docker exec $CONTAINER_NAME /bin/bash -c "cd /home/nextra/build/Nextra/install/linux.x86_64/samples/nextra-rest-server/java/standard && ./fly.sh" &
sleep 2

# Run nextra-rest-server 
sudo docker exec $CONTAINER_NAME /bin/bash -c "cd /tmp && nextra-rest-server.sh" &
