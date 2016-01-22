Overview
========

Chef cookbook for linux basic configuration like following recipes.

Recipes
========
* coredump
* cron
* dns
* shell environment
* groups
* hosts
* init
* ipv6
* kdump
* kernel
* locale
* mail
* motd
* network
* ntp
* pkg
* proxy
* rsyslog
* selinux
* service
* snmp
* ssh
* sudo
* timezone
* users
* yum

Requirements
============

Platform:

* CentOS-5.x,6.x, Red Hat

The following Opscode cookbooks are dependencies:

* chef-client, yum


Repository Directories
======================

* `cookbooks/` - Cookbooks you download.
* `data_bags/` - Store data bags and items in .json in the repository.
* `environments/` - Store environments in  or .json in the repository.
* `roles/` - Store roles in  or .json in the repository.
* `site-cookbooks/` - Cookbooks you create.

Example
=============

* Download cookbook from https://supermarket.chef.io

  ```
  berks vendor cookbooks
  ```

* Update some files for your environment

```
data_bags/groups/
data_bags/users/
site-cookbooks/linux/attributes
```

* Create node and add role:linux to run_list

```
knife node create NODE
```

json example:

    {
      "name": "NODE",
      "chef_environment": "development",
      "normal": {
        "tags": [

        ],
        "description": "DESCRIPTION"
      },
      "run_list": [
        "role[linux]"
      ]
    }
