#
# Cookbook Name:: linux
# Recipe:: mail
#
@recipe = "mail"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    template "submit.mc" do
        only_if { File.exists?("/etc/mail/submit.mc") }
        path "/etc/mail/submit.mc"
        source "etc/mail/submit.mc.erb"
        owner "root"
        group "root"
        mode "0644"
    end

    template "submit.cf" do
        only_if { File.exists?("/etc/mail/submit.cf") }
        path "/etc/mail/submit.cf"
        source "etc/mail/submit.cf.erb"
        owner "root"
        group "root"
        mode "0644"
    end

    cron "msp" do
        only_if { File.exists?("/etc/mail/submit.cf") }
        user "root"
        command "/usr/lib/sendmail -Ac -q > /dev/null 2>&1"
        minute "0,30"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
