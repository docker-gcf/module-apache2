{% set locals = {"httpd_conf_path": None} %}
{% set paths = [
   "/usr/local/apache2/conf/httpd.conf",
   "/etc/apache2/apache2.conf"
] %}

{% for path in paths %}
  {% if salt['file.file_exists'](path) %}
    {% do locals.update({"httpd_conf_path": path}) %}
  {% endif %}
{% endfor %}

{% if locals["httpd_conf_path"] %}

docker-gcf-apache2-config:
  file.blockreplace:
      - name: {{ locals["httpd_conf_path"] }}
      - append_if_not_found: True
      - marker_start: "#-- start managed zone docker-gcf-apache2 --"
      - marker_end: "#-- end managed zone docker-gcf-apache2 --"
      - content: |
{% raw %}
                   LogFormat "%{%Y-%m-%d %H:%M:%S}t %v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
                   LogFormat "%{%Y-%m-%d %H:%M:%S}t %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" combined
                   LogFormat "%{%Y-%m-%d %H:%M:%S}t %h %l %u \"%r\" %>s" common
{% endraw %}
{% else %}
docker-gcf-apache2-config:
  test.fail_without_changes:
    - name: "apache2 configuration file not found"
    - failhard: True
{% endif %}
