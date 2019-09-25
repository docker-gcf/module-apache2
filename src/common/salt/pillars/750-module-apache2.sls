{% if stack['module_apache2']['httpd_conf']['server_name'] %}
module_apache2:
  httpd_conf:
    blocks:
      - ServerName {{ stack['module_apache2']['httpd_conf']['server_name'] | string }}
{% endif %}
{% if stack['module_apache2']['default_site']['document_root'] %}
  default_site:
    blocks:
      - DocumentRoot {{ stack['module_apache2']['default_site']['document_root'] | string }}
{% endif %}
