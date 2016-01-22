#
# Cookbook Name:: linux
# Recipe:: sudo
#
@recipe = "sudo"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "sudoers" do
        only_if { File.exists?("/etc/sudoers") }
        path "/etc/sudoers"
        source "etc/sudoers.erb"
        owner "root"
        group "root"
        mode "0644"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
