#配置sshd
check_ssh_timeout()
{
    if grep -q "#This file has been edited by Xray-TLS-Web-setup-script" /etc/ssh/sshd_config; then
        return 0
    fi
    sed -i '/^[ \t]*ClientAliveInterval[ \t]/d' /etc/ssh/sshd_config
    sed -i '/^[ \t]*ClientAliveCountMax[ \t]/d' /etc/ssh/sshd_config
    echo >> /etc/ssh/sshd_config
    echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
    echo "ClientAliveCountMax 60" >> /etc/ssh/sshd_config
    echo "#This file has been edited by Xray-TLS-Web-setup-script" >> /etc/ssh/sshd_config
    systemctl restart sshd
    echo  "----------------------配置完成----------------------"
    echo " 请重新连接服务器以让配置生效"
    exit 0
}
check_ssh_timeout
