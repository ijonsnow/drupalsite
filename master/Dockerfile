FROM ubuntu:12.04

MAINTAINER rajendra vm "rajendra.vm87@gmail.com"

RUN apt-get -qq update 

RUN DEBIAN-FRONTEND=noninteractive apt-get install -y mysql-client  mysql-server 

RUN /usr/bin/mysqld &\
    sleep 10s &&\
    echo "GRANT ALL PRIVILEGES TO 'admin'@'%' IDENTIFIED BY 'captain' WITH GRANT OPTION;FLUSH PRIVILEGES" | mysql

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]



