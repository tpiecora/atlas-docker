FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="stream service for atlas"

# nginx
RUN yum install -y epel-release && yum clean all
RUN yum install -y nginx && yum clean all
#RUN rm /etc/nginx/conf.d/*.conf
COPY ./stream/stream-nginx.conf /etc/nginx/conf.d/stream-nginx.conf

# node
RUN curl -sL https://rpm.nodesource.com/setup_5.x | bash - && yum install -y nodejs && yum clean all

# kinesis mock service
RUN npm install kinesalite

# certificates for mocking aws kinesis
COPY ./certs/ /certs/


COPY ./stream/start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

# ports for kinesis and ssl
EXPOSE 443 80 4567

ENTRYPOINT ["/etc/start.sh"]