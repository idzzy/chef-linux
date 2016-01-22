#
# Cookbook Name:: linux
# Recipe:: service
#
@recipe = "service"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    # disable, stop
    %w{
        NetworkManager
        atd
        canna
        ip6tables
        lpd
        sendmail
        postfix
        haldaemon
        multipathd
        kdump
        #iscsi
        #iscsid
        #nfs
        #netfs
        #nfslock
    }.each do |service_name|
        service service_name do
            action [:disable, :stop]
            only_if "systemctl status #{service_name}"
        end
    end

    # enable, start
    %w{
        sshd
        snmpd
        psacct
        sysstat
    }.each do |service_name|
        service service_name do
            supports :restart => true, :status => true
            action [:enable, :start]
            not_if "systemctl status #{service_name}"
        end
    end

    # enable, start (not reload)
    %w{
        ntpd
    }.each do |service_name|
        service service_name do
            supports :restart => true, :reload => false, :status => true
            action [:enable, :start]
            not_if "systemctl status #{service_name}"
        end
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
