#
# Cookbook Name:: linux
# Recipe:: users
#
@recipe = "users"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    data_ids = data_bag('users')
    data_ids.each do |id|
        u = data_bag_item('users', id)

        # Add new users
        node["users"]["lists"].each do |def_users|
            if u['username'] == def_users then

                user u['username'] do
                    home u['home']
                    password u['password']
                    shell u['shell']
                    uid u['uid']
                    gid u['gid']
                    action :create
                end
            end
        end

        # Update root password
        if u['username'] == "root" then
            user u['username'] do
                password u['password']
                action :modify
            end
        end
    end

    # Rock root account
    #execute 'rock root' do
    #    command 'usermod -L root'
    #end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
