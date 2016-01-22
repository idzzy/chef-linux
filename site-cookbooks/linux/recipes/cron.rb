#
# Cookbook Name:: linux
# Recipe:: cron
#
@recipe = "cron"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    cookbook_file "cron.allow" do
        path "/etc/cron.allow"
        source "etc/cron.allow"
        owner "root"
        group "root"
        mode "0644"
    end

    cookbook_file "cron.deny" do
        path "/etc/cron.deny"
        source "etc/cron.deny"
        owner "root"
        group "root"
        mode "0644"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
