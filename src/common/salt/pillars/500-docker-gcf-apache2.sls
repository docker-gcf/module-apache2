{% set cmds = [
   "httpd-foreground",
   "docker-php-entrypoint apache2-foreground"
] %}
{% set cmd = salt['module_apache2.get_first_existing_cmd'](cmds) %}

{% set httpd_conf_paths = [
   "/usr/local/apache2/conf/httpd.conf",
   "/etc/apache2/apache2.conf"
] %}
{% set httpd_conf_path = salt['module_apache2.get_first_existing_path'](httpd_conf_paths) %}

{% set default_site_conf_paths = [
   "/etc/apache2/sites-available/000-default.conf",
   "/usr/local/apache2/conf/httpd.conf"
] %}
{% set default_site_conf_path = salt['module_apache2.get_first_existing_path'](default_site_conf_paths) %}

gcf:
  modules:
    apache2:
      cmd: {{ cmd }}
      httpd_conf_path: {{ httpd_conf_path }}
      default_site_conf_path: {{ default_site_conf_path }}
      server_name: apache2
      document_root: False
