{% from "dagster/map.jinja" import dagster with context %}

{% for pkg in dagster.pkgs %}
test_{{pkg}}_is_installed:
  testinfra.package:
    - name: {{ pkg }}
    - is_installed: True
{% endfor %}
