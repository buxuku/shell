#!/bin/bash


# 按照官方的教程也比较简单，但因为镜像在国外，在国内的服务器上面安装，会非常慢。这里记录下通过国内源的安装方式
#1.更新yum索引
yum update
#2.安装一些必要的依赖包
yum install -y yum-utils device-mapper-persistent-data lvm2
#3.设置docker-ce仓库
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#4.安装docker
yum makecache fast
yum install docker-ce

#5.使用阿里镜像加速,xxx需要替换成自己的地址
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://xxx.mirror.aliyuncs.com"]
}
EOF

#6.设置开机自启
systemctl enable docker
#7.启动docker服务
systemctl start docker
#安装docker-compose
#直接参考http://get.daocloud.io/#install-compose

curl -L https://get.daocloud.io/docker/compose/releases/download/1.28.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
