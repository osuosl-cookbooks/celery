class Chef
  class Resource::Celery < Resource
    include Poise

    actions(:create)

    attribute(:app, kind_of: String, default: "")
    attribute(:bin, kind_of: String, default: "/usr/bin/celery")
    attribute(:chdir, kind_of: String, default: "/tmp")
    attribute(:nodes, kind_of: Array, default: ["node1"])
    attribute(:opts, kind_of: String, default: "--time-limit=300")
    attribute(:logfile, kind_of: String, default: "/var/log/celery/%N.log")
    attribute(:pidfile, kind_of: String, default: "/var/run/celery/%N.pid")

    attribute(:makeuser, kind_of: [TrueClass,FalseClass], default: true)
    attribute(:user, kind_of: String, default: "celery")
    attribute(:makegroup, kind_of: [TrueClass,FalseClass], default: true)
    attribute(:group, kind_of: String, default: "celery")

    attribute(:createlogdir, kind_of: [TrueClass,FalseClass], default: 1)
    attribute(:createpiddir, kind_of: [TrueClass,FalseClass], default: 1)
    attribute(:createdirs, kind_of: [TrueClass,FalseClass,NilClass], default: 1)

    attribute(:extraopts, kind_of: Hash, default: {})

    attribute(:installmethod, kind_of: String, default: "source")
  end

  class Provider::Celery < Provider
    include Poise

    def action_create()
      converge_by("Creating resource #{new_resource.name}") do
        notifying_block do

          cookbook_file "/etc/init.d/celery_#{new_resource.name}" do
            cookbook "celery"
            source "celeryd"
            mode "755"
          end

          if new_resource.makeuser
            user new_resource.user
          end

          if new_resource.makegroup
              group new_resource.group do
                members [new_resource.user]
              end
          end

          template "/etc/default/celery_#{new_resource.name}" do
            source "celery.erb"
            cookbook "celery"
            variables ({
              app: new_resource.app,
              bin: new_resource.bin,
              chdir: new_resource.chdir,
              nodes: new_resource.nodes,
              opts: new_resource.opts,
              logfile: new_resource.logfile,
              pidfile: new_resource.pidfile,
              user: new_resource.user,
              group: new_resource.group,
              createlogdir: new_resource.createlogdir,
              createpiddir: new_resource.createpiddir,
              createdirs: new_resource.createdirs,
              extraopts: new_resource.extraopts
            })
          end

          case new_resource.installmethod
          when "source"
            include_recipe "python"

            python_pip "distribute" do
              action :upgrade
            end

          when "package"
            include_recipe 'yum-ius'
            %w[ python27 python27-pip python27-virtualenv].each { |p| package p }
            node.override['python']['binary'] = '/usr/bin/python2.7'
            node.override['python']['pip_location'] = '/usr/bin/pip2.7'
          else
            Chef::Log.warn "node['celery']['installmethod'] is set to #{node['celery']['installmethod']} which is unrecognized. Installing celery may fail..."
          end

          python_pip "celery"

          service "celery_#{new_resource.name}" do
            action [:enable, :start]
          end
        end
      end
    end
  end
end
