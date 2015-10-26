#!/bin/sh

CONTAINER_NAME=nextra

sudo docker rm $CONTAINER_NAME

# -v /etc/localtime:/etc/localtime does not work on Virtual Box
# sudo docker run --name $CONTAINER_NAME --privileged -i -t -d -p 8080:8080 -v /etc/localtime:/etc/localtime:ro centos7_nextra /sbin/init
sudo docker run --name $CONTAINER_NAME --privileged -i -t -d -p 8080:8080 centos7_nextra /sbin/init

# Run broker and rpcjava 2 samples
sudo docker exec $CONTAINER_NAME /bin/bash -c "cd /home/nextra/build/Nextra/install/linux.x86_64/samples/nextra-rest-server/java/standard && ./fly.sh" &
sleep 2

# Run nextra-rest-server 
sudo docker exec $CONTAINER_NAME /bin/bash -c "cd /tmp && nextra-rest-server.sh" &

#sudo docker exec $CONTAINER_NAME /bin/bash -c "cd /home/nextra/build/Nextra/install/linux.x86_64/samples/nextra-rest-server/java/standard && broker -e broker.env -bg" &
