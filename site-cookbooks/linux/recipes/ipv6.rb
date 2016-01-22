#
# Cookbook Name:: linux
# Recipe:: ipv6
#
@recipe = "ipv6"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    if node['platform_version'].to_i == 7 then
        cookbook_file "/etc/sysctl.d/disableipv6.conf" do
            owner "root"
            group "root"
            mode "0644"
            source "etc/sysctl.d/disableipv6.conf"
        end

    elsif node['platform_version'].to_i == 6 then

        cookbook_file "/etc/modprobe.d/disable-ipv6.conf" do
            owner "root"
            group "root"
            mode "0644"
            source "etc/modprobe.d/disable-ipv6.conf"
        end

        ruby_block "update /etc/sysconfig/network" do
            block do
                rc = Chef::Util::FileEdit.new("/etc/sysconfig/network")
                rc.insert_line_if_no_match(/^NETWORKING_IPV6.*$/, "NETWORKING_IPV6=no")
                rc.write_file
            end
            not_if "grep '^NETWORKING_IPV6' /etc/sysconfig/network"
        end

        ruby_block "edit /etc/sysctl.conf" do
            block do
                rc = Chef::Util::FileEdit.new("/etc/sysctl.conf")
                rc.insert_line_if_no_match(/^# ipv6 disable$/, "# ipv6 disable")
                rc.write_file
                rc.insert_line_if_no_match(/^net.ipv6.conf.all.disable_ipv6.*$/, "net.ipv6.conf.all.disable_ipv6 = 1")
                rc.write_file
                rc.insert_line_if_no_match(/^net.ipv6.conf.default.disable_ipv6.*$/, "net.ipv6.conf.default.disable_ipv6 = 1")
                rc.write_file
            end
            not_if "grep '^NETWORKING_IPV6' /etc/sysconfig/network"
        end

    end

else
    Chef::Log.error("@recipw recipe does not support '#{node['platform']}' platform")
end
