#!/bin/sh
#sudo docker rm nextra
sudo docker run --name nextra --privileged -i -t -d -p 50080:80 -p 39001:39001 -p 39002:39002 centos7_nextra /sbin/init
