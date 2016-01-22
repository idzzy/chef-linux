#
# Cookbook Name:: linux
# Recipe:: kernel
#
@recipe = "kernel"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    ruby_block "edit /etc/sysctl.conf" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/sysctl.conf")
            #rc.insert_line_if_no_match(/^# Do less swapping.*$/, "# Do less swapping")
            #rc.write_file
            #rc.insert_line_if_no_match(/^#vm.swappiness.*$/, "#vm.swappiness = 0")
            #rc.write_file
            rc.insert_line_if_no_match(/^# Disable IP spoofing protection.*$/, "# Disable IP spoofing protection")
            rc.write_file
            rc.insert_line_if_no_match(/^net.ipv4.conf.all.rp_filter.*$/, "net.ipv4.conf.all.rp_filter = 0")
            rc.write_file
            rc.insert_line_if_no_match(/^# Controls the use of TCP syncookies.*$/, "# Controls the use of TCP syncookies")
            rc.write_file
            rc.insert_line_if_no_match(/^net.ipv4.tcp_syncookies.*$/, "net.ipv4.tcp_syncookies = 1")
            rc.write_file
            #rc.insert_line_if_no_match(/^# No overcommitment of available memory.*$/, "# No overcommitment of available memory")
            #rc.write_file
            #rc.insert_line_if_no_match(/^#vm.overcommit_memory.*$/, "#vm.overcommit_memory = 2")
            #rc.write_file
            rc.insert_line_if_no_match(/^# Enable OOM.*$/, "# Enable OOM")
            rc.write_file
            rc.insert_line_if_no_match(/^vm.panic_on_oom.*$/, "vm.panic_on_oom = 1")
            rc.write_file
            rc.insert_line_if_no_match(/^# Disable ipv6.*$/, "# Disable ipv6")
            rc.write_file
            rc.insert_line_if_no_match(/^net.ipv6.conf.all.disable_ipv6.*$/, "net.ipv6.conf.all.disable_ipv6 = 1")
            rc.write_file
            rc.insert_line_if_no_match(/^net.ipv6.conf.default.disable_ipv6.*$/, "net.ipv6.conf.default.disable_ipv6 = 1")
            rc.write_file
        end
        not_if "grep '^# Enable OOM' /etc/sysctl.conf"
        #notifies :run, "execute[reload /etc/sysctl.conf]"
    end

    execute "reload /etc/sysctl.conf" do
        command "sysctl -e -p"
        action :nothing
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
