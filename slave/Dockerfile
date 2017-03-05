FROM ubuntu:12.04

MAINTAINER rajendra vm "rajendra.vm87@gmail.com"

RUN apt-get -qq update 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client  mysql-server 

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN sed -i -e"s/^#server-id\t\t=\s1/server-id\t\t= 2/" /etc/mysql/my.cnf



RUN cat /etc/mysql/my.cnf

RUN /usr/sbin/mysqld & \

    sleep 10s &&\

    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'rights' WITH GRANT OPTION;CHANGE MASTER TO MASTER_HOST='172.0.0.1', MASTER_USER='repl',MASTER_PASSWORD='repl', MASTER_LOG_FILE='mysql-bin.000001',MASTER_LOG_POS=0; FLUSH PRIVILEGES" | mysql

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]



