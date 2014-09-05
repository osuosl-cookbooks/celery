default['celery']['nodes'] = ['node1']
default['celery']['bin-path'] = '/usr/local/bin/celery'
default['celery']['app'] = 'tasks'
default['celery']['chdir'] = ''
default['celery']['opts'] = "--time-limit=300"
default['celery']['log-file'] = '/var/log/celery/%N.log'
default['celery']['pid-file'] = '/var/run/celer/%N.pid'

default['celery']['make-user'] = true
default['celery']['user'] = 'celery'
default['celery']['make-group'] = true
default['celery']['group'] = 'celery'

default['celery']['create-log-dir'] = 0
default['celery']['create-run-dir'] = 0
default['celery']['create-dirs'] = 1

default['celery']['install-package'] = true
default['celery']['celery-install-method'] = 'package'

