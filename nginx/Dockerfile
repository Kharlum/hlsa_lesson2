FROM centos:7

ARG NGINX_VERSION

RUN useradd -M -s /sbin/nologin nginx

RUN yum -y update
RUN yum -y install make gcc gcc-gcc pcre-devel zlib-devel

RUN curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz > /usr/local/src/nginx-${NGINX_VERSION}.tar.gz && \
    cd /usr/local/src && tar zxf nginx-${NGINX_VERSION}.tar.gz

WORKDIR /usr/local/src/nginx-${NGINX_VERSION}

RUN ./configure \
    --user=nginx \
    --group=nginx \
    --prefix=/usr/local/nginx \
    --with-http_stub_status_module && \
    make && make install && rm -rf /usr/local/src/*

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

ENV PATH /usr/local/nginx/sbin:$PATH

EXPOSE 80

ENTRYPOINT [ "nginx" ]

CMD [ "-g", "daemon off;" ]
