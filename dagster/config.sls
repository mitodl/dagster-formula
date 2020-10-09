#!pyobjects
#~*~ mode: Python ~*~
import yaml

dagster = salt.jinja.load_map('dagster/map.jinja', 'dagster')

include('.service')

File.managed(
    'dagster_instance_configuration_file',
    name='{0}/dagster.yaml'.format(dagster['home']),
    contents=yaml.dump(dagster['instance_config'], default_flow_style=False),
    user=dagster['user'],
    group=dagster['group'],
    onchanges_in=[Service('dagster_service_running')]
)

for pipeline, config in dagster['pipeline_configs'].items():
    File.managed(
        'configure_settings_for_{0}_pipeline'.format(pipeline),
        name='{0}/{1}.yaml'.format(dagster['config_dir'], pipeline),
        user=dagster['user'],
        group=dagster['group'],
        makedirs=True,
        contents=yaml.dump(config, default_flow_style=False),
        onchanges_in=[Service('dagster_service_running')]
    )
