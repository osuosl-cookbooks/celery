user "celery" do
    action :create
end

cookbook_file "celeryd" do
    path "/etc/init.d/celeryd"
    action :create
    mode "755"
end

template "/etc/default/celeryd" do
    source "central/celeryd.erb"
    action :create
end

service "celeryd" do
    action [:enable, :start]
    subscribes :restart, "template[/etc/default/celeryd]"
end
