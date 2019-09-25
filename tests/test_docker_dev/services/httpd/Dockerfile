FROM httpd:2.4

ADD https://raw.githubusercontent.com/docker-gcf/docker-gcf/develop/setup.sh /tmp/docker-gcf-setup.sh
RUN sh /tmp/docker-gcf-setup.sh
COPY ./src/ /tmp/module-apache2/src/
RUN sh /usr/local/src/docker-gcf/src/setup.sh -m file:///tmp/module-apache2/
ENTRYPOINT ["gcf-entrypoint"]
CMD ["gcf-cmd"]

COPY ./tests/test_docker_dev/services/httpd/config/ /etc/salt/base/
COPY ./tests/test_docker_dev/services/httpd/wwwroot/ /usr/local/apache2/htdocs/
