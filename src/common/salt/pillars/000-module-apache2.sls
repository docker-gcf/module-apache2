{% set cmds = [
   "httpd-foreground",
   "docker-php-entrypoint apache2-foreground"
] %}
{% set cmd = __salt__['module_apache2.get_first_existing_cmd'](cmds) %}

{% set httpd_conf_paths = [
   "/usr/local/apache2/conf/httpd.conf",
   "/etc/apache2/apache2.conf"
] %}
{% set httpd_conf_path = __salt__['module_apache2.get_first_existing_path'](httpd_conf_paths) %}

{% set default_site_conf_paths = [
   "/etc/apache2/sites-available/000-default.conf",
   "/usr/local/apache2/conf/httpd.conf"
] %}
{% set default_site_conf_path = __salt__['module_apache2.get_first_existing_path'](default_site_conf_paths) %}

gcf:
  supervisor:
    programs:
      apache2:
        extraConfig:
          command: {{ cmd }}

module_apache2:
  httpd_conf:
    path: {{ httpd_conf_path }}
    server_name: apache2
    blocks:
      - |
          {% raw %}ErrorLogFormat "[%-m:%l] [pid %P:tid %T] %7F: %E: [client\ %a] %M% ,\ referer\ %{Referer}i"{% endraw %}
          <IfModule log_config_module>
            {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined{% endraw %}
            {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" combined{% endraw %}
            {% raw %}  LogFormat "%v:%p %h %l %u \"%r\" %>s \"%{Referer}i\" \"%{User-Agent}i\"" common{% endraw %}
          </IfModule>
  default_site:
    path: {{ default_site_conf_path }}
    document_root: False
    blocks: []
