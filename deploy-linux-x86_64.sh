#!/bin/bash
set -ex

workspace=/opt/als
mkdir -p ${workspace}
cd ${workspace}

# 下载, arm 机器替换 x86_64 为 aarch64
OS_ARCH="x86_64"
#下载部署包
wget --no-check-certificate -qO "als-linux-${OS_ARCH}.zip"  "https://github.com/fujikang/als/releases/download/als-linux-${OS_ARCH}.zip"
#解压部署包
unzip -o "als-linux-${OS_ARCH}.zip"

# systemd service
mv -v als-linux-${OS_ARCH}.service /etc/systemd/system/als-linux-${OS_ARCH}.service

#处理可执行包
mkdir -p /opt/als
mv als-linux-${OS_ARCH}  /opt/als
chmod +X /opt/als/als-linux-${OS_ARCH} 


systemctl daemon-reload

# 使用以下命令开机自启
systemctl enable als-linux-${OS_ARCH}

# 启动
systemctl start als-linux-${OS_ARCH}

# 状态查看
systemctl status als-linux-${OS_ARCH}
