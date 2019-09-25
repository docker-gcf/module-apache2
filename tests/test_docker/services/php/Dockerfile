FROM php:7-apache-stretch

ADD https://raw.githubusercontent.com/docker-gcf/docker-gcf/develop/setup.sh /tmp/docker-gcf-setup.sh
RUN sh /tmp/docker-gcf-setup.sh -m apache2=develop
ENTRYPOINT ["gcf-entrypoint"]
CMD ["gcf-cmd"]

COPY ./php/config/ /etc/salt/base/
COPY ./php/wwwroot/ /var/www/html/
