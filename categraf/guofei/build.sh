#!/bin/bash

##################################################################
# 脚本作用：编译代码 && 传输到linux上
##################################################################

script_dir=`dirname $0`
cd ${script_dir}/..
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build
sshpass -p 1 ssh root@172.16.1.128 "mkdir -p /root/categraf" || exit 1
sshpass -p 1 scp categraf root@172.16.1.128:/root/categraf/  || (echo "传输失败" && exit 1)
sshpass -p 1 scp categraf root@172.16.1.128:/root/categraf/  || (echo "传输失败" && exit 1)