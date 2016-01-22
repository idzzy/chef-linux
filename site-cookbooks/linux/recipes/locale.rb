#
# Cookbook Name:: linux
# Recipe:: locale
#
@recipe = "locale"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    os_version = node['platform_version'].to_i
    if os_version == 7 then
        if  File.exists?("/etc/sysconfig/i18n") && ! "/etc/sysconfig/i18n".include?("en_US.UTF-8")
            f = Chef::Util::FileEdit.new("/etc/sysconfig/i18n")
            f.search_file_replace_line(/^LANG=.*$/, "LANG=\"en_US.UTF-8\"")
            f.write_file
            f.insert_line_if_no_match(/^LC_CTYPE=.*$/, "LC_CTYPE=\"en_US.UTF-8\"")
            f.write_file
        end

    elsif os_version == 6 then
        if File.exists?("/etc/local.conf") 
            ruby_block "edit /etc/locale.conf" do
                block do
                    rc = Chef::Util::FileEdit.new("/etc/locale.conf")
                    rc.insert_line_if_no_match(/^LANG=.*$/, "LANG=\"en_US.UTF-8\"")
                    rc.write_file
                    rc.insert_line_if_no_match(/^LC_CTYPE=.*$/, "LC_CTYPE=\"en_US.UTF-8\"")
                    rc.write_file
                end
                not_if "grep '^LANG=' /etc/locale.conf"
            end
        end

    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
