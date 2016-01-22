#--------------------------------------------------
# attribute - development
#--------------------------------------------------
default["mngsvr"]["stepserver"] = ["10.63.1.110","10.63.1.111"]
default["mngsvr"]["dns"] = ["10.16.1.12","10.16.1.13"]
default["mngsvr"]["syslog"] = ["10.16.2.13","10.16.2.14"]
default["mngsvr"]["ntp"] = ["10.16.1.14","10.16.1.15"]
default["mngsvr"]["tftp"] = ["10.16.2.8","10.16.2.9"]
default["mngsvr"]["smtp"] = ["10.16.1.14","10.16.1.15"]
default["mngsvr"]["snmptrap"] = ["10.17.1.38","10.17.1.39"]
default["mngsvr"]["proxy"] = "10.32.64.31"
default["mngsvr"]["proxy_port"] = "8080"
