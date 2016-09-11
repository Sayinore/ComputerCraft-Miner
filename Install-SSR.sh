#!/bin/sh

#define shadowsocks passwords
pwd1=oyy1jPsOoefvtc2M
pwd2=vp0Q4uvv00xUvNCb
pwd3=p85hS1nh0at8GJpz
pwd4=qD-AUT4H-SuaXeQp
pwd5=od_uLTJFhyXE71nq
pwd6=Wz5CdWC9T-FBiJBR

#define DNS servers
dns1=119.29.29.29
dns2=178.79.131.110

#define shadowsocks ports
p1=23
p2=53
p3=80
p4=143
p5=194
p6=443

#install libraries
sudo yum install python-setuptools && easy_install pip
sudo yum install git

#change dir
cd -L
cd /usr/local/

#get code
sudo git clone -b manyuser https://github.com/breakwa11/shadowsocks.git "/usr/local/shadowsocks"

#change dir
cd shadowsocks

#change into json mode
sudo echo "# Config" > userapiconfig.py
sudo echo "API_INTERFACE = 'mudbjson' #mudbjson, sspanelv2, sspanelv3, sspanelv3ssr, muapiv2(not support)" >> userapiconfig.py
sudo echo "UPDATE_TIME = 60" >> userapiconfig.py
sudo echo "SERVER_PUB_ADDR = '127.0.0.1' # mujson_mgr need this to generate ssr link" >> userapiconfig.py
sudo echo "" >> userapiconfig.py
sudo echo "#mudb" >> userapiconfig.py
sudo echo "MUDB_FILE = 'mudb.json'" >> userapiconfig.py
sudo echo "" >> userapiconfig.py
sudo echo "# Mysql" >> userapiconfig.py
sudo echo "MYSQL_CONFIG = 'usermysql.json'" >> userapiconfig.py
sudo echo "" >> userapiconfig.py
sudo echo "# API" >> userapiconfig.py
sudo echo "MUAPI_CONFIG = 'usermuapi.json'" >> userapiconfig.py
sudo echo "" >> userapiconfig.py
sudo echo "" >> userapiconfig.py
sudo echo "" >> userapiconfig.py

#set server configs
sudo echo -e "{" > user-config.json
sudo echo -e "\t\"server\":\"0.0.0.0\"," >> user-config.json
sudo echo -e "\t\"server_ipv6\": \"[::]\"," >> user-config.json
sudo echo -e "\t\"local_address\":\"127.0.0.1\"," >> user-config.json
sudo echo -e "\t\"local_port\":1080," >> user-config.json
sudo echo -e "\t\"port_password\":{" >> user-config.json
sudo echo -e "\t\t\"$p1\":\"$pwd1\"," >> user-config.json
sudo echo -e "\t\t\"$p2\":\"$pwd2\"" >> user-config.json
sudo echo -e "\t\t\"$p3\":\"$pwd3\"" >> user-config.json
sudo echo -e "\t\t\"$p4\":\"$pwd4\"" >> user-config.json
sudo echo -e "\t\t\"$p5\":\"$pwd5\"" >> user-config.json
sudo echo -e "\t\t\"$p6\":\"$pwd6\"" >> user-config.json
sudo echo -e "\t}," >> user-config.json
sudo echo -e "\t\"timeout\":500," >> user-config.json
sudo echo -e "\t\"method\":\"aes-256-cfb\"," >> user-config.json
sudo echo -e "\t\"protocol\": \"auth_sha1_v2\"," >> user-config.json
sudo echo -e "\t\"protocol_param\": \"1\"," >> user-config.json
sudo echo -e "\t\"obfs\": \"tls1.2_ticket_auth\"," >> user-config.json
sudo echo -e "\t\"obfs_param\": \"\"," >> user-config.json
sudo echo -e "\t\"redirect\": \"cloudfront.net\"," >> user-config.json
sudo echo -e "\t\"dns_ipv6\": false," >> user-config.json
sudo echo -e "\t\"fast_open\": false," >> user-config.json
sudo echo -e "\t\"workers\": 1" >> user-config.json
sudo echo -e "}" >> user-config.json

#set DNS configs
sudo echo "$dns1" > dns.conf
sudo echo "$dns2" >> dns.conf

#set connecting configsu
sudo iptables -I INPUT -p tcp --dport $p1 -m connlimit --connlimit-above 1 -j DROP
sudo iptables -I INPUT -p tcp --dport $p2 -m connlimit --connlimit-above 1 -j DROP
sudo iptables -I INPUT -p tcp --dport $p3 -m connlimit --connlimit-above 1 -j DROP
sudo iptables -I INPUT -p tcp --dport $p4 -m connlimit --connlimit-above 1 -j DROP
sudo iptables -I INPUT -p tcp --dport $p5 -m connlimit --connlimit-above 1 -j DROP
sudo iptables -I INPUT -p tcp --dport $p6 -m connlimit --connlimit-above 1 -j DROP

#creat start script
sudo echo -e "#!/bin/sh" >> /etc/init.d/shadowsocks
sudo echo -e "# chkconfig: 2345 90 10" >> /etc/init.d/shadowsocks
sudo echo -e "# description: Start or stop the Shadowsocks R server" >> /etc/init.d/shadowsocks
sudo echo -e "#" >> /etc/init.d/shadowsocks
sudo echo -e "### BEGIN INIT INFO" >> /etc/init.d/shadowsocks
sudo echo -e "# Provides: Shadowsocks-R" >> /etc/init.d/shadowsocks
sudo echo -e "# Required-Start: $network $syslog" >> /etc/init.d/shadowsocks
sudo echo -e "# Required-Stop: $network" >> /etc/init.d/shadowsocks
sudo echo -e "# Default-Start: 2 3 4 5" >> /etc/init.d/shadowsocks
sudo echo -e "# Default-Stop: 0 1 6" >> /etc/init.d/shadowsocks
sudo echo -e "# Description: Start or stop the Shadowsocks R server" >> /etc/init.d/shadowsocks
sudo echo -e "### END INIT INFO" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "# Author: Yvonne Lu(Min) <min@utbhost.com>" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "name=shadowsocks" >> /etc/init.d/shadowsocks
sudo echo -e "PY=/usr/bin/python" >> /etc/init.d/shadowsocks
sudo echo -e "SS=/usr/local/shadowsocks/server.py" >> /etc/init.d/shadowsocks
sudo echo -e "SSPY=server.py" >> /etc/init.d/shadowsocks
sudo echo -e "conf=/usr/local/shadowsocks/user-config.json" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "start(){" >> /etc/init.d/shadowsocks
sudo echo -e "    $PY $SS -c $conf -d start" >> /etc/init.d/shadowsocks
sudo echo -e "    RETVAL=$?" >> /etc/init.d/shadowsocks
sudo echo -e "    if [ \"$RETVAL\" = \"0\" ]; then" >> /etc/init.d/shadowsocks
sudo echo -e "        echo \"$name start success\"" >> /etc/init.d/shadowsocks
sudo echo -e "    else" >> /etc/init.d/shadowsocks
sudo echo -e "        echo \"$name start failed\"" >> /etc/init.d/shadowsocks
sudo echo -e "    fi" >> /etc/init.d/shadowsocks
sudo echo -e "}" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "stop(){" >> /etc/init.d/shadowsocks
sudo echo -e "    pid=`ps -ef | grep -v grep | grep -v ps | grep -i \"${SSPY}\" | awk '{print $2}'`" >> /etc/init.d/shadowsocks
sudo echo -e "    if [ ! -z $pid ]; then" >> /etc/init.d/shadowsocks
sudo echo -e "        $PY $SS -c $conf -d stop" >> /etc/init.d/shadowsocks
sudo echo -e "        RETVAL=$?" >> /etc/init.d/shadowsocks
sudo echo -e "        if [ \"$RETVAL\" = \"0\" ]; then" >> /etc/init.d/shadowsocks
sudo echo -e "            echo \"$name stop success\"" >> /etc/init.d/shadowsocks
sudo echo -e "        else" >> /etc/init.d/shadowsocks
sudo echo -e "            echo \"$name stop failed\"" >> /etc/init.d/shadowsocks
sudo echo -e "        fi" >> /etc/init.d/shadowsocks
sudo echo -e "    else" >> /etc/init.d/shadowsocks
sudo echo -e "        echo \"$name is not running\"" >> /etc/init.d/shadowsocks
sudo echo -e "        RETVAL=1" >> /etc/init.d/shadowsocks
sudo echo -e "    fi" >> /etc/init.d/shadowsocks
sudo echo -e "}" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "status(){" >> /etc/init.d/shadowsocks
sudo echo -e "    pid=`ps -ef | grep -v grep | grep -v ps | grep -i \"${SSPY}\" | awk '{print $2}'`" >> /etc/init.d/shadowsocks
sudo echo -e "    if [ -z $pid ]; then" >> /etc/init.d/shadowsocks
sudo echo -e "        echo \"$name is not running\"" >> /etc/init.d/shadowsocks
sudo echo -e "        RETVAL=1" >> /etc/init.d/shadowsocks
sudo echo -e "    else" >> /etc/init.d/shadowsocks
sudo echo -e "        echo \"$name is running with PID $pid\"" >> /etc/init.d/shadowsocks
sudo echo -e "        RETVAL=0" >> /etc/init.d/shadowsocks
sudo echo -e "    fi" >> /etc/init.d/shadowsocks
sudo echo -e "}" >> /etc/init.d/shadowsocks
sudo echo -e "" >> /etc/init.d/shadowsocks
sudo echo -e "case \"$1\" in" >> /etc/init.d/shadowsocks
sudo echo -e "'start')" >> /etc/init.d/shadowsocks
sudo echo -e "    start" >> /etc/init.d/shadowsocks
sudo echo -e "    ;;" >> /etc/init.d/shadowsocks
sudo echo -e "'stop')" >> /etc/init.d/shadowsocks
sudo echo -e "    stop" >> /etc/init.d/shadowsocks
sudo echo -e "    ;;" >> /etc/init.d/shadowsocks
sudo echo -e "'status')" >> /etc/init.d/shadowsocks
sudo echo -e "    status" >> /etc/init.d/shadowsocks
sudo echo -e "    ;;" >> /etc/init.d/shadowsocks
sudo echo -e "'restart')" >> /etc/init.d/shadowsocks
sudo echo -e "    stop" >> /etc/init.d/shadowsocks
sudo echo -e "    start" >> /etc/init.d/shadowsocks
sudo echo -e "    RETVAL=$?" >> /etc/init.d/shadowsocks
sudo echo -e "    ;;" >> /etc/init.d/shadowsocks
sudo echo -e "*)" >> /etc/init.d/shadowsocks
sudo echo -e "    echo \"Usage: $0 { start | stop | restart | status }\"" >> /etc/init.d/shadowsocks
sudo echo -e "    RETVAL=1" >> /etc/init.d/shadowsocks
sudo echo -e "    ;;" >> /etc/init.d/shadowsocks
sudo echo -e "esac" >> /etc/init.d/shadowsocks
sudo echo -e "exit $RETVAL" >> /etc/init.d/shadowsocks

#run server
chmod 755 /etc/init.d/shadowsocks
chkconfig --add shadowsocks
service shadowsocks start

#add service
sudo echo '[Unit]' >> /etc/systemd/system/shadowsocks.service
sudo echo 'Description=Start or stop the ShadowsocksR server' >> /etc/systemd/system/shadowsocks.service
sudo echo 'After=network.target' >> /etc/systemd/system/shadowsocks.service
sudo echo 'Wants=network.target' >> /etc/systemd/system/shadowsocks.service
sudo echo '[Service]' >> /etc/systemd/system/shadowsocks.service
sudo echo 'Type=forking' >> /etc/systemd/system/shadowsocks.service
sudo echo 'PIDFile=/var/run/shadowsocks.pid' >> /etc/systemd/system/shadowsocks.service
sudo echo 'ExecStart=/usr/bin/python /usr/local/shadowsocks/server.py --pid-file /var/run/shadowsocks.pid -c /etc/shadowsocks.json -d start' >> /etc/systemd/system/shadowsocks.service
sudo echo 'ExecStop=/usr/bin/python /usr/local/shadowsocks/server.py --pid-file /var/run/shadowsocks.pid -c /etc/shadowsocks.json -d stop' >> /etc/systemd/system/shadowsocks.service
sudo echo '[Install]' >> /etc/systemd/system/shadowsocks.service
sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/shadowsocks.service

#set limits
echo '* soft nofile 51200' >> /etc/security/limits.conf
echo '* hard nofile 51200' >> /etc/security/limits.conf
