#!/bin/bash
if [ $1 == "" ];then echo 请带域名使用脚本谢谢;exit ;fi
yum >/dev/null 2>&1
if [ $? == 0 ];then
#yum update -y
yum install -y curl socat
bash xui.sh
else
apt update -y
apt install -y curl socat
bash xui.sh
fi

curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --register-account -m `date +%s%N | cut -c10-20`@qq.com
~/.acme.sh/acme.sh  --issue -d "$1".alanwind.online   --standalone
~/.acme.sh/acme.sh --installcert -d "$1".alanwind.online --key-file /root/private.key --fullchain-file /root/cert.crt

cd /root
wget https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_386.tar.gz
tar -zxvf frp_0.38.0_linux_386.tar.gz
mv frp_0.38.0_linux_386 frp
cd frp/
rm -rf frpc*
#vim frps.ini
nohup ./frps -c frps.ini >/dev/null 2>&1 &
echo "nohup /root/frp/frps -c /root/frp/frps.ini >/dev/null 2>&1 &" >>/etc/rc.local
chmod +x /etc/rc.local >/dev/null 2>&1 &
chmod +x /etc/rc.d/rc.local >/dev/null 2>&1 &
