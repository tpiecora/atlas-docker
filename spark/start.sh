#!/bin/bash

#############################################
# /etc/bootstrap.sh from sequenceiq/spark
#############################################
: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

# setting spark defaults
echo spark.yarn.jar hdfs:///spark/spark-assembly-1.6.0-hadoop2.7.1.jar > $SPARK_HOME/conf/spark-defaults.conf
cp $SPARK_HOME/conf/metrics.properties.template $SPARK_HOME/conf/metrics.properties

service sshd start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
#############################################
# END /etc/bootstrap.sh from sequenceiq/spark
#############################################

# Spark Master IP is IP of first interface
CONTAINER_IP=$(getent hosts `hostname` | awk '{ print $1 }')

# Point AWS services to self
echo "$CONTAINER_IP kinesis.us-east-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.us-east-1.amazonaws.com" >> /etc/hosts
echo "$CONTAINER_IP master" >> /etc/hosts

# # Start nginx
nginx &

hdfs dfsadmin -safemode leave


# # Tail spark driver/executor log output
sleep 10 # why have to do this??
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*3/stdout ; do sleep 1 ; done 2> /dev/null &
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*3/stderr ; do sleep 1 ; done 2> /dev/null &
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*2/stdout ; do sleep 1 ; done 2> /dev/null &
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*2/stderr ; do sleep 1 ; done 2> /dev/null &
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*1/stdout ; do sleep 1 ; done 2> /dev/null &
while ! tail -n +0 -f /usr/local/hadoop/logs/userlogs/*/*1/stderr ; do sleep 1 ; done 2> /dev/null &

wait