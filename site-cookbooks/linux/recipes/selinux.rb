#
# Cookbook Name:: linux
# Recipe:: selinux
#
@recipe = "selinux"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    ruby_block "edit /etc/sysconfig/selinux" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/sysconfig/selinux")
            rc.search_file_replace_line(/^SELINUX=.*$/, "SELINUX=disabled")
            rc.write_file
        end
        not_if "grep '^SELINUX=disabled' /etc/sysconfig/selinux"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
