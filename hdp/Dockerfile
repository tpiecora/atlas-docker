FROM sequenceiq/pam:centos-6.5

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122

USER root

# hdp variables
ENV HDP_VERSION=2.4.0.0-169
ENV HADOOP_PREFIX /usr/hdp/$HDP_VERSION/hadoop
ENV HADOOP_COMMON_HOME /usr/hdp/$HDP_VERSION/hadoop
ENV HADOOP_HDFS_HOME /usr/hdp/$HDP_VERSION/hadoop-hdfs
ENV HADOOP_MAPRED_HOME /usr/hdp/$HDP_VERSION/hadoop-mapred
ENV HADOOP_YARN_HOME /usr/hdp/$HDP_VERSION/hadoop-yarn
ENV HADOOP_CONF_DIR /usr/hdp/$HDP_VERSION/hadoop/conf
ENV YARN_CONF_DIR $HADOOP_PREFIX/hadoop/libexec

RUN mkdir /var/lib/hadoop-hdfs
RUN chmod 755 /var/lib/hadoop-hdfs

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# java
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
RUN rpm -i jdk-7u71-linux-x64.rpm
RUN rm jdk-7u71-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin
RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

#COPY ./hdp3/resolv.conf /etc/resolv.conf
#RUN cat /etc/resolv.conf

RUN yum install -y wget

# hdp repo and install hdp
COPY ./hdp3/hdp.repo /etc/yum.repos.d/hdp.repo
RUN yum install -y hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client spark_2_4_0_0_169-master spark_2_4_0_0_169-python openssl
RUN yum install -y snappy snappy-devel


RUN yum clean all


# load in our hdp config
RUN rm -rf /usr/hdp/$HDP_VERSION/hadoop/conf
COPY ./hdp3/conf /usr/hdp/$HDP_VERSION/hadoop/conf

# add trusted certificate authorities
COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore $JAVA_HOME/jre/lib/security/cacerts

# dummy aws keys
ENV AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
ENV AWS_SECRET_ACCESS_KEY=ZBBBBBBBBBBBBBBBB/ooooooooooooooooooooo0


COPY ./hdp3/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh", "-d"]