#!/bin/bash
: ${HADOOP_PREFIX:=/usr/hdp/2.4.0.0-169/hadoop}
$HADOOP_PREFIX/conf/hadoop-env.sh

hdfs dfsadmin -safemode leave

service sshd start

$HADOOP_PREFIX/bin/hdfs namenode -format
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode 
hdfs datanode &
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start nodemanager

CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
	service sshd stop
	/usr/sbin/sshd -D -d
else
	/bin/bash -c "$*"
fi