{% set state_name = "docker-gcf-apache2" %}

{% if salt['pillar.get']('module_apache2:httpd_conf_path') %}
{{ state_name }}-config:
  file.blockreplace:
      - name: {{ salt['pillar.get']('module_apache2:httpd_conf_path') }}
      - append_if_not_found: True
      - marker_start: "#-- start managed zone {{ state_name }} --"
      - marker_end: "#-- end managed zone {{ state_name }} --"
      - content: |
                   ServerName {{ salt['pillar.get']('module_apache2:server_name') }}
                   {% raw %}ErrorLogFormat "[%-m:%l] [pid %P:tid %T] %7F: %E: [client\ %a] %M% ,\ referer\ %{Referer}i"{% endraw %}
                   <IfModule log_config_module>
                   {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined{% endraw %}
                   {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" combined{% endraw %}
                   {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" common{% endraw %}
                   </IfModule>
{% else %}
{{ state_name }}-config:
  test.fail_without_changes:
    - name: "apache2 configuration file not found"
    - failhard: True
{% endif %}


{% if salt['pillar.get']('module_apache2:document_root') %}
{% if salt['pillar.get']('module_apache2:default_site_conf_path') %}
{{ state_name }}-config-document-root:
  file.line:
    - name: {{ salt['pillar.get']('module_apache2:default_site_conf_path') }}
    - match: DocumentRoot .*
    - mode: replace
    - content: DocumentRoot {{ salt['pillar.get']('module_apache2:document_root') }}
{% else %}
{{ state_name }}-config-document-root:
  test.fail_without_changes:
      - name: "apache2 default site configuration file not found"
      - failhard: True
{% endif %}
{% endif %}
