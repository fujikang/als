#!/bin/bash
set -ex

WORKSPACE=/opt/als
mkdir -p ${WORKSPACE}
cd ${WORKSPACE}

# 下载, arm 机器替换 x86_64 为 aarch64
OS_ARCH="aarch64"
#下载部署包
wget --no-check-certificate -qO "als-${OS_ARCH}.zip"  "https://github.com/fujikang/als/releases/download/als-${OS_ARCH}.zip"
#解压部署包
unzip -o "als-${OS_ARCH}.zip"

# systemd service
mv -v als-${OS_ARCH}.service /etc/systemd/system/als-${OS_ARCH}.service

systemctl daemon-reload

# 使用以下命令开机自启
systemctl enable als-${OS_ARCH}

# 启动
systemctl start als-${OS_ARCH}

# 状态查看
systemctl status als-${OS_ARCH}



# 停止
# systemctl stop stat_server
# systemctl stop stat_client

# https://fedoraproject.org/wiki/Systemd/zh-cn
# https://docs.fedoraproject.org/en-US/quick-docs/understanding-and-administering-systemd/index.html

# 修改 /etc/systemd/system/stat_client.service 文件，将IP改为你服务器的IP或你的域名
