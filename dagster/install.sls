#!pyobjects
#~*~ mode: Python ~*~

dagster = salt.jinja.load_map('dagster/map.jinja', 'dagster')

include('.service')

User.present(
    'create_dagster_user',
    name=dagster['user'],
    home=dagster['home'],
    require_in=Service('dagster_service_running')
)

Group.present(
    'create_dagster_group',
    name=dagster['group'],
    require_in=Service('dagster_service_running')
)

Pkg.installed(
    'install_dagit_and_dagster_packages',
    sources=dagster['pkg_sources'],
    require_in=Service('dagster_service_running')
)

File.managed(
    'create_dagit_systemd_unit',
    name='/etc/systemd/system/dagit.service',
    template='jinja',
    source='salt://dagster/templates/dagster.service.j2',
    context={
        'user': dagster['user'],
        'dagster_home': dagster['home'],
        'dagit_path': dagster['dagit']['path'],
        'dagit_port': dagster['dagit']['port'],
        'dagit_listen_address': dagster['dagit']['listen_address'],
        'dagit_flags': ' '.join(dagster['dagit']['flags'])
    },
    require_in=Service('dagster_service_running')
)
