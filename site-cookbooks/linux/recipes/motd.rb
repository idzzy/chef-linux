#
# Cookbook Name:: linux
# Recipe:: motd
#
@recipe = "motd"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "motd" do
        only_if { File.exists?("/etc/motd") }
        path "/etc/motd"
        source "etc/motd.erb"
        owner "root"
        group "root"
        mode "0644"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
