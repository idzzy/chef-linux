#
# Cookbook Name:: linux
# Recipe:: groups
#
@recipe = "groups"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    data_ids = data_bag('groups')
    data_ids.each do |id|
        g = data_bag_item('groups', id)

        group g['groupname'] do
            gid g['gid']
            action :create
        end
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
