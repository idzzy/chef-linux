#
# Cookbook Name:: linux
# Recipe:: yum
#
@recipe = "yum"
Chef::Log.info("#{recipe_name} recipe in the #{cookbook_name} cookbook.")

case node['platform']
when "centos"

    # Add EPEL repo
    version = node['platform_version'].to_i 
    yum_repository 'epel' do
        description 'Extra Packages for Enterprise Linux'
        mirrorlist "http://mirrors.fedoraproject.org/metalink?repo=epel-#{version}&arch=$basearch"
        gpgkey "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-#{version}"
        action :create
    end

    # Delete CentOS-Media repo
    yum_repository 'CentOS-Media' do
        action :delete
    end

    # Install yum-fastestmirror, yum-priorities
    #%w{
    #    yum-fastestmirror
    #    yum-priorities
    #}.each do |package_name|
    #    package package_name do
    #        action [:install]
    #    end
    #end

    # Update yum.conf
    ruby_block "edit /etc/yum.conf" do
        block do
            rc = Chef::Util::FileEdit.new("/etc/yum.conf")
            rc.insert_line_if_no_match(/^# Exclude Pkg.*$/, "# Exclude Pkg")
            rc.write_file
            rc.insert_line_after_match(/^# Exclude Pkg.*$/, "#exclude=kernel* centos*")
            rc.write_file
        end
        not_if "grep '#exclude=kernel\\* centos\\*' /etc/yum.conf"
    end

    #execute "yum-update" do
    #    user "root"
    #    command "yum -y update"
    #    action :run
    #end

else
    Chef::Log.error("@recipe recipe does not support '#{node['platform']}' platform")
end
