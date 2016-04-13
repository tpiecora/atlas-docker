FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="storage service for atlas"

RUN yum install -y epel-release centos-release-scl && yum clean all
RUN yum install -y java-1.7.0-openjdk && yum clean all
RUN yum install -y nginx && yum clean all

RUN ls /usr/lib/java
RUN ls /usr/lib/jvm/jre-1.7.0-openjdk

COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore /usr/lib/jvm/jre-1.7.0-openjdk/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore /usr/lib/jvm/jre-1.7.0-openjdk/lib/security/cacerts


COPY ./start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]