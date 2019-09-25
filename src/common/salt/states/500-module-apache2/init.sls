{% set state_name = "docker-gcf-apache2" %}

{% if salt['pillar.get']('module_apache2:httpd_conf:path') %}
{{ state_name }}-httpd-blocks:
  file.blockreplace:
      - name: {{ salt['pillar.get']('module_apache2:httpd_conf:path') }}
      - append_if_not_found: True
      - marker_start: "#-- start managed zone {{ state_name }}-httpd-blocks --"
      - marker_end: "#-- end managed zone {{ state_name }}-httpd-blocks --"
      - content: {{ salt['pillar.get']('module_apache2:httpd_conf:blocks') | join('\n') | string | yaml }}
{% else %}
{{ state_name }}-httpd-blocks:
  test.fail_without_changes:
    - name: "apache2 configuration file not found"
    - failhard: True
{% endif %}


{% if salt['pillar.get']('module_apache2:default_site:path') %}
{{ state_name }}-default_site-marker:
  file.replace:
      - name: {{ salt['pillar.get']('module_apache2:default_site:path') }}
      - pattern: \n((?!default_site-blocks).)*\n</VirtualHost>\n
      - repl: "\n#-- start managed zone {{ state_name }}-default_site-blocks --\n#-- end managed zone {{ state_name }}-default_site-blocks --\n</VirtualHost>"

{{ state_name }}-default_site-blocks:
  file.blockreplace:
      - name: {{ salt['pillar.get']('module_apache2:default_site:path') }}
      - append_if_not_found: True
      - marker_start: "#-- start managed zone {{ state_name }}-default_site-blocks --"
      - marker_end: "#-- end managed zone {{ state_name }}-default_site-blocks --"
      - content: {{ salt['pillar.get']('module_apache2:default_site:blocks') | join('\n') | string | yaml }}
{% else %}
{{ state_name }}-default_site-blocks:
  test.fail_without_changes:
      - name: "apache2 default site configuration file not found"
      - failhard: True
{% endif %}
