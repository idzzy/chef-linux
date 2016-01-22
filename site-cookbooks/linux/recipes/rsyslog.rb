#
# Cookbook Name:: linux
# Recipe:: rsyslog
#
@recipe = "rsyslog"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "rsyslog.conf" do
        only_if { File.exists?("/etc/rsyslog.conf") }
        path "/etc/rsyslog.conf"
        source "etc/rsyslog.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        notifies :restart, 'service[rsyslog]'
    end

    service "rsyslog" do
        supports :status => true, :restart => true
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
