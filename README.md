# Drupal-Site

Launch Drupal site, with backend mysql database and setup mysql master-slave replication.

Setups includes 3 docker containers.

1) Master mysql database -> Exposed on port number 3308 container level.
2) Slave mysql database -> Exposed on  port number 3307 container level.
3) Drupal website -> Exposed on port number 8001 at container level.


How to setup?

* clone the above repository drupalsite
* Prerequisites
  > docker-engine setup on ubuntu instance
  > docker-compose setup

* Run docker-compose commands to build and run the docker containers.
  > command to build the docker images.
     sudo docker-compose build 

  > command to run the launch the containers from the build image
     sudo docker-compose up -d
  
  Note: It is not mandatory to execute "docker-compose build" command before "docker-compose up". Command "docker-compose up" executes build and run commands together.



* Launch drupal website in browser,https://localhost:8001/drupal. 
Follow the instructions of drupal website launch.


* Keep a note of gateway ip address of masterdb using command, docker inspect masterdb | grep "Gateway: ".
Provide the ip address and database credentials at the time of drupal site database setup step process.





