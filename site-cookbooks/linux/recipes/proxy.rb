#
# Cookbook Name:: linux
# Recipe:: proxy
#
@recipe = "proxy"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    # environment
    ruby_block "edit /etc/environment" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/environment")
            rc.insert_line_if_no_match(/^# Proxy.*$/, "# Proxy")
            rc.write_file
            rc.insert_line_if_no_match(/^https_proxy=.*$/, "#https_proxy=http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}")
            rc.write_file
            rc.insert_line_if_no_match(/^http_proxy=.*$/, "#http_proxy=http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}")
            rc.write_file
            rc.insert_line_if_no_match(/^HTTPS_PROXY.*$/, "#HTTPS_PROXY=http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}")
            rc.write_file
            rc.insert_line_if_no_match(/^HTTP_PROXY.*$/, "#HTTP_PROXY=http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}")
            rc.write_file
        end
        not_if "grep 'http_proxy' /etc/environment"
    end

    # yum
    ruby_block "edit /etc/yum.conf" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/yum.conf")
            rc.insert_line_if_no_match(/^# Proxy.*$/, "# Proxy")
            rc.write_file
            rc.insert_line_if_no_match(/^proxy=.*$/, "proxy=http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}")
            rc.write_file
        end
        not_if "grep 'Proxy' /etc/yum.conf"
    end

    # wget
    ruby_block "edit /etc/wgetrc" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/wgetrc")
            rc.search_file_replace_line(/^#http_proxy =.*$/, "http_proxy = http://#{node['mngsvr']['proxy']}:#{node['mngsvr']['proxy_port']}/")
            rc.write_file
        end
        only_if "grep '#http_proxy' /etc/wgetrc"
    end

    # curl
    template "/root/.curlrc" do
        source "root/.curlrc.erb"
        owner "root"
        group "root"
        mode "0644"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
