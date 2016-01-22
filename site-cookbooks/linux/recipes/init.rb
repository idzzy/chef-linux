#
# Cookbook Name:: linux
# Recipe:: init
#
@recipe = "init"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    if node['platform_version'].to_i == 7 then
        link '/etc/systemd/system/ctrl-alt-del.target' do
            to '/dev/null'
            action :create
            not_if { File.exists?("/etc/systemd/system/ctrl-alt-del.target") }
        end

    elsif node['platform_version'].to_i == 6 then
        ruby_block "edit /etc/init/control-alt-delete.conf" do
            block do
                rc = Chef::Util::FileEdit.new("/etc/init/control-alt-delete.conf")
                rc.search_file_replace_line(/^exec \/sbin\/shutdown.*$/, "#exec /sbin/shutdown -r now \"Control-Alt-Delete pressed\"")
                rc.write_file
            end
            not_if "grep '#exec /sbin/shutdown' /etc/init/control-alt-delete.conf"
        end

    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
