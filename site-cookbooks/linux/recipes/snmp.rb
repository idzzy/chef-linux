#
# Cookbook Name:: linux
# Recipe:: snmp
#
@recipe = "snmp"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "snmpd.conf" do
        only_if { File.exists?("/etc/snmp/snmpd.conf") }
        path "/etc/snmp/snmpd.conf"
        source "etc/snmp/snmpd.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        notifies :reload, 'service[snmpd]'
    end

    service "snmpd" do
        supports :status => true, :restart => true, :reload => true
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
