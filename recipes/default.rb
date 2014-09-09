#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright (C) 2014 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'celery::_user' if node['celery']['make-user']
include_recipe 'celery::_group' if node['celery']['make-group']
include_recipe 'celery::_package' if node['celery']['install-package']

cookbook_file '/etc/init.d/celeryd' do
  mode 0755
end

template '/etc/default/celeryd'

service 'celeryd' do
  action [:enable, :start]
  subscribes :restart, 'template[/etc/default/celeryd]'
end
