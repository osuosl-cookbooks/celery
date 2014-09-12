default['celery']['app'] = 'tasks'
default['celery']['bin'] = '/usr/bin/celery'
default['celery']['chdir'] = ''
default['celery']['nodes'] = ['node1']
default['celery']['opts'] = "--time-limit=300"
default['celery']['logfile'] = '/var/log/celery/%N.log'
default['celery']['pidfile'] = '/var/run/celer/%N.pid'

default['celery']['makeuser'] = true
default['celery']['user'] = 'celery'
default['celery']['makegroup'] = true
default['celery']['group'] = 'celery'

default['celery']['createlogdir'] = 0
default['celery']['createpiddir'] = 0
default['celery']['createdirs'] = 1

default['celery']['extraopts'] = {}
