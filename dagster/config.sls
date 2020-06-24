{% from "dagster/map.jinja" import dagster with context %}

include:
  - .install
  - .service

dagster-config:
  file.managed:
    - name: {{ dagster.conf_file }}
    - source: salt://dagster/templates/conf.jinja
    - template: jinja
    - watch_in:
      - service: dagster_service_running
    - require:
      - pkg: dagster
