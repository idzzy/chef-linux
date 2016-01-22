#
# Cookbook Name:: linux
# Recipe:: pkg
#
@recipe = "pkg"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    %w{
        wget
        curl
        telnet
        dstat
        net-snmp
        net-snmp-utils
        nc
        tcpdump
        mtr
        ntp
        ntpdate
        bind-utils
        lsof
        htop
        iotop
        iftop
        tree
        psmisc
        kexec-tools
        psacct
        sysstat
        vim-common
        vim-enhanced
    }.each do |pkg|
        package pkg do
            action :install
        end
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
