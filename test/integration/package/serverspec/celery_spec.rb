require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe user("celery") do
  it { should exist }
end

describe group('celery') do
  it { should exist }
end

describe process('python2.7') do
  its(:args) { should match /celery/ }
  it { should be_running }
end

