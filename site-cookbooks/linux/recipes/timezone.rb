#
# Cookbook Name:: linux
# Recipe:: timezone
#
@recipe = "timezone"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    execute 'set timezone JST-9' do
        command 'rm -f /etc/localtime && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime'
        not_if 'grep "^JST" /etc/localtime'
    end

    cookbook_file "clock" do
        path "/etc/sysconfig/clock"
        source "etc/sysconfig/clock"
        owner "root"
        group "root"
        mode "0644"
        not_if 'grep "Tokyo" /etc/sysconfig/clock'
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
