#
# Cookbook Name:: linux
# Recipe:: network
#
@recipe = "network"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    ruby_block "edit /etc/sysconfig/network" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/sysconfig/network")
            # APIPA
            rc.insert_line_if_no_match(/^NOZEROCONF=.*$/, "NOZEROCONF=yes")
            rc.write_file
            # NETWORK
            rc.insert_line_if_no_match(/^NETWORKING=.*$/, "NETWORKING=yes")
            rc.write_file
        end
        not_if "grep '^NOZEROCONF' /etc/sysconfig/network"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
