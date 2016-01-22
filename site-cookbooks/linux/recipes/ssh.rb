#
# Cookbook Name:: linux
# Recipe:: ssh
#
@recipe = "ssh"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "sshd.conf" do
        only_if { File.exists?("/etc/ssh/sshd.conf") }
        path "/etc/ssh/sshd.conf"
        source "etc/ssh/sshd.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        notifies :reload, 'service[sshd]'
    end

    template "ssh.conf" do
        only_if { File.exists?("/etc/ssh/ssh.conf") }
        path "/etc/ssh/ssh.conf"
        source "etc/ssh/ssh.conf.erb"
        owner "root"
        group "root"
        mode "0644"
    end

    service "sshd" do
        supports :status => true, :restart => true, :reload => true
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
