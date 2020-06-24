{% from "dagster/map.jinja" import dagster with context %}

include:
  - .service

dagster:
  pkg.installed:
    - pkgs: {{ dagster.pkgs }}
    - require_in:
        - service: dagster_service_running
