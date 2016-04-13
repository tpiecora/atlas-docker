FROM sequenceiq/hadoop-docker:2.7.0
MAINTAINER SequenceIQ

#support for Hadoop 2.7.0
COPY spark-1.6.0-bin-hadoop-2.7_scala-2.10.tgz /tmp/spark-1.6.0-bin-hadoop-2.7_scala-2.10.tgz
RUN tar zxvf /tmp/spark-1.6.0-bin-hadoop-2.7_scala-2.10.tgz -C /usr/local/ 
RUN rm -f /tmp/spark-1.6.0-bin-hadoop-2.7_scala-2.10.tgz

RUN cd /usr/local && ln -s spark-1.6.0-bin-hadoop-2.7_scala-2.10 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-1.6.0-bin-hadoop-2.7_scala-2.10/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin
# update boot script
COPY start.sh /etc/start.sh
RUN chown root.root /etc/start.sh
RUN chmod 700 /etc/start.sh

RUN yum install -y epel-release && yum clean all
RUN yum install -y nginx && yum clean all

#install R
#RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install R

#RUN yum install -y java-1.7.0-openjdk nginx && yum clean all

COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore $JAVA_HOME/jre/lib/security/cacerts


ENV AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
ENV AWS_SECRET_ACCESS_KEY=ZBBBBBBBBBBBBBBBB/ooooooooooooooooooooo0

RUN echo "log4j.logger.com.amazonaws.services.kinesis.metrics.impl=ERROR" >> /usr/local/spark/conf/log4j.properties

RUN rm /etc/nginx/conf.d/*.conf
COPY ./container-nginx.conf /etc/nginx/conf.d/container-nginx.conf

EXPOSE 8080 8081 8088 8042 4040 443 80


ENTRYPOINT ["/etc/start.sh"]