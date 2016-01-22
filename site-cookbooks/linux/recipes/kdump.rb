#
# Cookbook Name:: linux
# Recipe:: kdump
#
@recipe = "kdump"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    cookbook_file "kdump.conf" do
        only_if "rpm -q kexec-tools"
        path "/etc/kdump.conf"
        source "etc/kdump.conf"
        owner "root"
        group "root"
        mode "0644"
        notifies :reload, 'service[kdump]'
    end

    service "kdump" do
        supports :status => true, :restart => true, :reload => true
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
