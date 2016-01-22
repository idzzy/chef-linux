#
# Cookbook Name:: linux
# Recipe:: ntp
#
@recipe = "ntp"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "ntp.conf" do
        only_if { File.exists?("/etc/ntp.conf") }
        path "/etc/ntp.conf"
        source "etc/ntp.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        notifies :reload, 'service[ntpd]'
    end

    service "ntpd" do
        supports :status => true, :restart => true, :reload => true
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
