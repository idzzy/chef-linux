#--------------------------------------------------
# default attribute
#--------------------------------------------------
# env
default[:env] = "development"
if "#{node[:env]}" == "development"
    include_attribute "linux::env_development"
elsif "#{node[:env]}" == "test"
    include_attribute "linux::env_test"
elsif "#{node[:env]}" == "production"
    include_attribute "linux::env_production"
end
# user
default["users"]["lists"] = [ "user01" ]
# dns
default["resolv"]["domain"] = "example.com"
default["resolv"]["search"] = "example.com"
# snmp
default["snmp"]["community"] = "COMMUNITY"
default["snmp"]["syslocation"] = "LOCATION"
default["snmp"]["syscontact"] = "admin@example.com"
# acl
default["acl_mask"]["snmp"] = ["192.168.0.0/255.255.255.0"]
default["acl_cidr"]["snmp"] = ["192.168.0.0/24"]
default["acl_mask"]["mngsubnet"] = "192.168.0.0/255.255.255.0"
default["acl_cidr"]["mngsubnet"] = "192.168.0.0/24"
default["acl_mask"]["stepserver"] = "192.168.0.2/255.255.255.0"
default["acl_cidr"]["stepserver"] = "192.168.0.2/24"
