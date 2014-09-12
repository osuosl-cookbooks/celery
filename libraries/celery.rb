class Chef
  class Resource::Celery < Resource
    include Poise

    actions(:create)

    attribute(:app, kind_of: String)
    attribute(:bin, kind_of: String)
    attribute(:chdir, kind_of: String)
    attribute(:nodes, kind_of: String)
    attribute(:opts, kind_of: String)
    attribute(:logfile, kind_of: String)
    attribute(:pidfile, kind_of: String)

    attribute(:makeuser, kind_of: [TrueClass,FalseClass])
    attribute(:user, kind_of: String)
    attribute(:makegroup, kind_of: [TrueClass,FalseClass])
    attribute(:group, kind_of: String)

    attribute(:createlogdir, kind_of: [TrueClass,FalseClass])
    attribute(:createpiddir, kind_of: [TrueClass,FalseClass])
    attribute(:createdirs, kind_of: [TrueClass,FalseClass,NilClass])

    attribute(:extraops, kind_of: Array)
  end

  class Provider::Celery < Provider
    include Poise

    def action_create()
      converge_by("Creating resource #{new_resource.name}") do
        notifying_block do
          cookbook_file "/etc/init.d/celeryd"

          template "/etc/default/celery" do
            variables (
              app: new_resource.app,
              bin: new_resource.bin,
              chdir: new_resource.chdir,
              nodes: new_resource.nodes,
              opts: new_resource.opts,
              logfile: new_resource.logfile,
              pidfile: new_resource.pidfile,
              makeuser: new_resource.makeuser,
              user: new_resource.user,
              makegroup: new_resource.makegroup,
              group: new_resource.group,
              createlogdir: new_resource.createlogdir,
              createpiddir: new_resource.createpiddir,
              createdirs: new_resource.createdirs
            )
          end
        end
      end
    end
  end
end
