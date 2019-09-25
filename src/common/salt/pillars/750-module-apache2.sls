module_apache2:
  httpd_conf:
    blocks:
{% stack['module_apache2']['httpd_conf']['server_name'] %}
      - ServerName {{ stack['module_apache2']['httpd_conf']['server_name'] | string }}
{% endif %}
  default_site:
    blocks:
{% if stack['module_apache2']['default_site']['document_root'] %}
      - DocumentRoot {{ stack['module_apache2']['default_site']['document_root'] | string }}
{% endif %}
