#
# Cookbook Name:: linux
# Recipe:: coredump
#
@recipe = "coredump"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    directory '/var/core' do
        owner 'root'
        group 'root'
        mode '0755'
        action :create
    end

    ruby_block "edit /etc/sysctl.conf" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/sysctl.conf")
            rc.insert_line_if_no_match(/^# Output CoreDump Directory.*$/, "# Output CoreDump Directory")
            rc.write_file
            rc.insert_line_if_no_match(/^kernel.core_pattern.*$/, "kernel.core_pattern=/var/core")
            rc.write_file
        end
        not_if "grep '# Output CoreDump Directory' /etc/sysctl.conf"
        #notifies :run, "execute[reload /etc/sysctl.conf]"
    end

    #execute "reload /etc/sysctl.conf" do
    #    command "sysctl -p"
    #    action :nothing
    #end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
