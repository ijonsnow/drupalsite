#! /bin/bash

FILE=`/usr/bin/realpath $0`

PROJECT=`/usr/bin/dirname $FILE`


build_slave(){

cd $PROJECT/slave

SlaveDir=`/bin/pwd`

SlaveDockerFile="$SlaveDir/Dockerfile"

if [ -f "$SlaveDockerFile" ]
	then
	   masterid=`sudo docker ps -a | grep -i up | grep -i "0.0.0.0:3306" | cut -d' ' -f1`
	   if [ $? -eq 0]
	   	then
	   	   masterip=`sudo docker inspect $masterid | grep -i gateway | cut -d':' -f2 | head -1 | cut -d'"' -f2`
	   	   if [ $? -eq 0]
	   	   	then
	   	   		`sed -i -e"s/{masterip}/$masterip/" Dockerfile`
	   	   		if [ $? -eq 0]
	   	   			then
	   	   			    continue
	   	   	    else
	   	   	    	echo "Master DB network ip is not found!"
	   	   	    fi
	   	    else
	   	    	echo "Master ip is not found!"
	   	    	return 1
	   	    fi	   	    
	   else
	   	 echo "Master container id is not found!"
	   	 return 1
	   fi
fi

if [ -f "$SlaveDockerFile" ]
then

    `sudo docker build -t slavedb .`

    if [ $? -eq 0]
    	then
    	     `sudo docker run -d -p 3307:3306 slavedb`
    	     if [ $? -eq 0]
    	     	then
    	     	    return 0
    	     else
    	     	echo "Master DB docker container failed!"
    	     	return 1
    else
    	echo "Master DB docker build failed!"
    	return 1
    fi
else
	echo "Master docker file doesn't exists"
	return 1
fi

}

build_master(){

cd $PROJECT/master

MasterDir=`/bin/pwd`

MasterDockerFile="$MasterDir/Dockerfile"

if [ -f "$MasterDockerFile" ]
then
    `sudo docker build -t masterdb .`

    if [ $? -eq 0]
    	then
    	     `sudo docker run -d -p 3306:3306 masterdb`
    	     if [ $? -eq 0]
    	     	then
    	     	    return 0
    	     else
    	     	echo "Master DB docker container failed!"
    	     	return 1
    else
    	echo "Master DB docker build failed!"
    	return 1
    fi
else
	echo "Master docker file doesn't exists"
	return 1
fi

}


build_drupal(){

cd $PROJECT/website-drupal

WebsiteDir=`/bin/pwd`

WebsiteDockerFile="$WebsiteDir/Dockerfile"

if [ -f "$WebsiteDockerFile" ]
	then
	    `sudo docker build -t drupal .`
	    if [ $? -eq 0]
	    	then
	    	   `sudo docker run -d -p 8001:80 drupal`
	    	   if [ $? -eq 0]
	    	   	then
	    	   	    continue
	    	   else
	    	   	   echo "Container Drupal failed to run !"
	    	   	   return 1
	    	   	fi
	    else
	    	echo "Drupal Docker build failed!"
	    	return 1
	    fi
else
	echo "Drupal Docker file doesn't exist!"
	return 1

fi

}



echo "Starting master db build server"
if [ $((build_master)) -eq 0 ]
	then
	   echo "Next: Building slave replication server"
	   if [[ $((build_slave)) -eq 0 ]]; then	   	  
	   	  echo "Next: Building Drupal website application"
	   	  if [[ $((build_drupal)) -eq 0 ]]; then
	   	  	 echo "Done: Drupal website hosted completely"
	   	  	 echo "Finished successfuly !!!"
	   	  else
	   	  	 echo "Failed: to host Drupal website"
	   	   fi 
	   else
	   	  echo "Failed: To run slave replication"
	   fi
else
	echo "Failed: To run master host"
fi













