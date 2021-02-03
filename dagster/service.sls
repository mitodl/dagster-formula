{% from "dagster/map.jinja" import dagster with context %}

dagster_service_running:
  service.running:
    - name: {{ dagster.service }}
    - enable: True


dagster_daemon_running:
  service.running:
    - name: {{ dagster.daemon }}
    - enable: True