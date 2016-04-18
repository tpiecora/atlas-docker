FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="storage service for atlas"

# java
RUN yum install -y java-1.7.0-openjdk && yum clean all

# nginx
RUN yum install -y epel-release && yum clean all
RUN yum install -y nginx && yum clean all
#RUN rm /etc/nginx/conf.d/*.conf
COPY ./storage/storage-nginx.conf /etc/nginx/conf.d/storage-nginx.conf

# certificates for mocking aws dynamodb
COPY ./certs/ /certs/

# dynamodb local
RUN mkdir /usr/dynamodb-local
RUN curl -L http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest | tar xz -C /usr/dynamodb-local

COPY ./storage/start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

# ports for dynamo and ssl
EXPOSE 443 80 8000

ENTRYPOINT ["/etc/start.sh"]