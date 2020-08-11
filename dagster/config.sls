#!pyobjects
#~*~ mode: Python ~*~
import yaml

dagster = salt.jinja.load_map('dagster/map.jinja', 'dagster')

include('.service')

File.managed(
    'dagster_configuration_file',
    name='{0}/dagster.yaml'.format(dagster['home']),
    contents=yaml.dump(dagster['config']['instance'], default_flow_style=False),
    user=dagster['user'],
    group=dagster['group'],
    onchanges_in=[Service('dagster_service_running')]
)
