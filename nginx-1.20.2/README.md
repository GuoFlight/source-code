# 关于项目

* 此项目用于源码学习，基于nginx 1.20.2
* 推荐使用IDE：VSCode

# 配置开发环境(Clion)

关于

* main函数所在文件：nginx-1.20.2/src/core/nginx.c

参考文档：

* https://blog.csdn.net/jackaing/article/details/133926039

设置gcc参数：

```shell
# 添加这些参数，可以让Clion找到依赖头文件，否则会大量飘红
-I ./src/core -I ./src/event -I ./src/event/modules -I ./src/os/unix -I ./pcre-8.43 -I ./src/http -I ./src/http/modules -I ./objs
```

编译生成objs目录

```shell
# nginx-1.20.2/src/core/ngx_config.h文件依赖这个objs中生成的ngx_auto_headers.h
cd <项目根目录>
./configure --prefix="./" --with-pcre=./pcre-8.43
```


# 初次编译

```shell
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-file-aio --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-pcre --with-pcre-jit --with-stream --with-stream_ssl_module --with-threads --with-debug --with-compat --with-mail=dynamic --with-mail_ssl_module --with-stream_geoip_module --with-http_image_filter_module=dynamic --with-http_stub_status_module
make && make install
cp -r contrib/vim/* /usr/share/vim/vimfiles/	# nginx配置文件在vim中语法高亮
ln -s /usr/local/nginx/conf/ /etc/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx
useradd -r -s /sbin/nologin nginx
mkdir -p /usr/local/nginx/run
vim /usr/lib/systemd/system/nginx.service
    [Unit]
    Description=The nginx HTTP and reverse proxy server
    After=network.target remote-fs.target nss-lookup.target

    [Service]
    Type=forking
    PIDFile=/usr/local/nginx/run/nginx.pid
    ExecStartPre=/usr/bin/rm -f /usr/local/nginx/run/nginx.pid
    ExecStartPre=/usr/sbin/nginx -t
    ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf
    ExecReload=/bin/kill -s HUP $MAINPID
    KillSignal=SIGQUIT
    TimeoutStopSec=5
    KillMode=process
    PrivateTmp=true
    LimitNOFILE=65535

    [Install]
    WantedBy=multi-user.target
vim /etc/nginx/nginx.conf
    pid /usr/local/nginx/run/nginx.pid;
systemctl daemon-reload
systemctl enable --now nginx
setenforce 0
systemctl stop firewalld
systemctl disable firewalld
```

# 再次编译

```sh
# 同步代码
rsync -avz --delete ./* root@172.16.1.128:/root/nginx/
编译、安装
./configure xxx
make && make install
# 重启
systemctl restart nginx
测试：curl http://127.0.0.1
```
