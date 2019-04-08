{% if salt['pillar.get']('gcf:modules:apache2:httpd_conf_path') %}
docker-gcf-apache2-config:
  file.blockreplace:
      - name: {{ salt['pillar.get']('gcf:modules:apache2:httpd_conf_path') }}
      - append_if_not_found: True
      - marker_start: "#-- start managed zone docker-gcf-apache2 --"
      - marker_end: "#-- end managed zone docker-gcf-apache2 --"
      - content: |
                   ServerName {{ salt['pillar.get']('gcf:modules:apache2:server_name') }}
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


{% if salt['pillar.get']('gcf:modules:apache2:document_root') %}
{% if salt['pillar.get']('gcf:modules:apache2:default_site_conf_path') %}
docker-gcf-apache2-config-document-root:
  file.line:
    - name: {{ salt['pillar.get']('gcf:modules:apache2:default_site_conf_path') }}
    - match: DocumentRoot .*
    - mode: replace
    - content: DocumentRoot {{ salt['pillar.get']('gcf:modules:apache2:document_root') }}
{% else %}
docker-gcf-apache2-config-document-root:
  test.fail_without_changes:
      - name: "apache2 default site configuration file not found"
      - failhard: True
{% endif %}
{% endif %}


docker-gcf-apache2-supervisor:
  file.managed:
    - name: /etc/supervisor/conf.d/apache2.conf
    - source: salt://500-docker-gcf-apache2/supervisor.conf
    - template: jinja
