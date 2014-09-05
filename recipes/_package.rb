#
# Cookbook Name:: celery
# Recipe:: _package
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

case node['celery']['celery-install-method']
when 'source'
  node.override['python']['install_method'] = 'source'
  include_recipe "python::default"
  include_recipe "python::pip"
when 'package'
  include_recipe 'yum-ius'
  %w[ python27 python27-pip python27-virtualenv ].each { |p| package p }
  node.override['python']['binary'] = '/usr/bin/python2.7'
  node.override['python']['pip_location'] = '/usr/bin/pip2.7'
  node.override['python']['virtualenv_location'] = '/usr/bin/virtualenv-2.7'
else
  Chef::Log.warn "node['celery']['celery-install-method'] is set to #{node['celery']['celery-install-method']} which is unrecognized. Installing celery may fail..."
end

python_pip "celery"
