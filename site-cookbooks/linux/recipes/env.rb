#
# Cookbook Name:: linux
# Recipe:: env
#
@recipe = "env"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    # /etc/bashrc
    cookbook_file "#{Chef::Config[:file_cache_path]}/bashrc" do
        source "etc/bashrc"
    end

    execute 'update /etc/bashrc' do
        cwd '/root'
        environment "HOME" => '/root'
        command <<-EOF
            cat #{Chef::Config[:file_cache_path]}/bashrc >> /etc/bashrc
        EOF
        not_if "grep '^# Alias' /etc/bashrc"
    end

    # /etc/profile
    cookbook_file "#{Chef::Config[:file_cache_path]}/profile" do
        source "etc/profile"
    end

    execute 'update /etc/profile' do
        cwd '/root'
        environment "HOME" => '/root'
        command <<-EOF
            cat #{Chef::Config[:file_cache_path]}/profile >> /etc/profile
        EOF
        not_if "grep '^# Env' /etc/profile"
    end

    # /etc/vimrc
    ruby_block "edit /etc/vimrc" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/vimrc")
            rc.insert_line_if_no_match(/formatoptions/, "au FileType * setlocal formatoptions-=ro")
            rc.write_file
        end
        not_if "grep 'formatoptions' /etc/vimrc"
    end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
