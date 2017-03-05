#! /bin/bash

`sudo apt-get update && sudo apt-get install git`

cd ~

`git clone https://github.com/rajendravm87/drupalsite`

cd ~/drupalsite

cd master

`sudo docker build -t masterdb .`

`sudo docker run -d -p 3306:3306 masterdb`

masterid=`sudo docker ps -a | grep -i up | grep -i "0.0.0.0:3306" | cut -d' ' -f1`

masterip=`sudo docker inspect $masterid | grep -i gateway | cut -d':' -f2 | head -1 | cut -d'"' -f2`

cd ..

cd slave

`sed -i -e"s/{masterip}/$masterip/" Dockerfile`


`sudo docker build -t slavedb .`

`sudo docker run -d -p 3307:3306 slavedb`

cd ..

cd website-drupal

`sudo docker build -t drupal .`

` sudo docker run -d -p 8001:80 drupal`







