# 编译
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
