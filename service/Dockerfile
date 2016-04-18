FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="storage service for atlas"

# java
RUN yum install -y java-1.7.0-openjdk && yum clean all

# nginx 
RUN yum install -y epel-release && yum clean all
RUN yum install -y nginx && yum clean all

#RUN ls /usr/lib/java
#RUN ls /usr/lib/jvm/jre-1.7.0-openjdk

# add trusted certificate authorities
COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore /usr/lib/jvm/jre-1.7.0-openjdk/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore /usr/lib/jvm/jre-1.7.0-openjdk/lib/security/cacerts

# dummy aws keys
ENV AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
ENV AWS_SECRET_ACCESS_KEY=ZBBBBBBBBBBBBBBBB/ooooooooooooooooooooo0

COPY ./service/start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]