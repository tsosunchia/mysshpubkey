#配置sshd
check_ssh_timeout()
{
    if grep -q "#This file has been edited by Xray-TLS-Web-setup-script" /etc/ssh/sshd_config; then
        return 0
    fi
    echo -e "\\n\\n\\n"
    tyblue "------------------------------------------"
    tyblue " 安装可能需要比较长的时间"
    tyblue " 如果中途断开连接将会很麻烦"
    tyblue " 设置ssh连接超时时间将有效降低断连可能性"
    echo
    ! ask_if "是否设置ssh连接超时时间？(y/n)" && return 0
    sed -i '/^[ \t]*ClientAliveInterval[ \t]/d' /etc/ssh/sshd_config
    sed -i '/^[ \t]*ClientAliveCountMax[ \t]/d' /etc/ssh/sshd_config
    echo >> /etc/ssh/sshd_config
    echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
    echo "ClientAliveCountMax 60" >> /etc/ssh/sshd_config
    echo "#This file has been edited by Xray-TLS-Web-setup-script" >> /etc/ssh/sshd_config
    systemctl restart sshd
    green  "----------------------配置完成----------------------"
    tyblue " 请重新连接服务器以让配置生效"
    if [ $in_install_update_xray_tls_web -eq 1 ]; then
        yellow " 重新连接服务器后，请再次运行脚本完成剩余部分的安装/升级"
        yellow " 再次运行脚本时，重复之前选过的选项即可"
        yellow " 按回车键退出。。。。"
        read -s
    fi
    exit 0
}
check_ssh_timeout
