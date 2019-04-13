FROM php:7-apache-stretch

ADD https://raw.githubusercontent.com/docker-gcf/docker-gcf/develop/setup.sh /tmp/docker-gcf-setup.sh
RUN sh /tmp/docker-gcf-setup.sh -m apache2=develop
ENTRYPOINT ["gcf-entrypoint"]
CMD ["supervisord", "-n"]

COPY ./config /etc/salt/base/
COPY ./wwwroot /var/www/html
