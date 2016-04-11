FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="storage service for atlas"

RUN mkdir /usr/dynamodb-local
RUN curl -L http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest | tar xz -C /usr/dynamodb-local
RUN yum install -y java-1.7.0-openjdk && yum clean all

COPY ./start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]