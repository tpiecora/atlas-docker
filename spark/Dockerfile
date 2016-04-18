FROM sequenceiq/hadoop-docker:2.7.1
MAINTAINER SequenceIQ

#support for Hadoop 2.7.0

# java - this thing already has java, but it's v.1.6, 
# which throws exceptions for our 1.7 compiled stuff
# or do we need 1.8?
RUN yum install -y java-1.7.0-openjdk && yum clean all

# spark
#RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz  | tar -xz -C /usr/local/
COPY ./spark/spark-hdp2.4 /usr/local/spark-hdp2.4
RUN cd /usr/local && ln -s spark-hdp2.4 spark


ENV SPARK_HOME /usr/local/spark

#COPY ./spark/spark-env.sh $SPARK_HOME/conf/spark-env.sh
# yarn
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD ./spark/yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-hdp2.4/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

# update boot script
COPY ./spark/start.sh /etc/start.sh
RUN chown root.root /etc/start.sh
RUN chmod 700 /etc/start.sh

# R
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install R

# add trusted certificate authorities
COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore $JAVA_HOME/jre/lib/security/cacerts

# dummy aws keys
ENV AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
ENV AWS_SECRET_ACCESS_KEY=ZBBBBBBBBBBBBBBBB/ooooooooooooooooooooo0

RUN echo "log4j.logger.com.amazonaws.services.kinesis.metrics.impl=ERROR" >> /usr/local/spark/conf/log4j.properties

# yarn, ssl ports
EXPOSE 8088 8042 443 80


ENTRYPOINT ["/etc/start.sh"]