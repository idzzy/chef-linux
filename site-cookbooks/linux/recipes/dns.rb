#
# Cookbook Name:: linux
# Recipe:: dns
#
@recipe = "dns"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "/etc/resolv.conf" do
        source "etc/resolv.conf.erb"
        owner "root"
        group "root"
        mode "0644"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
