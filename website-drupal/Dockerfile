FROM ubuntu:16.04

MAINTAINER rajendra vm "rajendra.vm87@gmail.com"

RUN apt-get -qqq update

RUN apt-get install -y apache2 php7.0* libapache2-mod-php7.0 


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

ADD drupal /var/www/html/drupal

RUN a2enmod php7.0 


EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]



