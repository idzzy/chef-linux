#
# Cookbook Name:: linux
# Recipe:: hosts
#
@recipe = "hosts"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "/etc/hosts" do
        owner "root"
        group "root"
        mode "0644"
        source "etc/hosts.erb"
    end

    template "/etc/hosts.allow" do
        owner "root"
        group "root"
        mode "0644"
        source "etc/hosts.allow.erb"
    end

    cookbook_file "/etc/hosts.deny" do
        owner "root"
        group "root"
        mode "0644"
        source "etc/hosts.deny"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
