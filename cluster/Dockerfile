FROM sequenceiq/spark:1.6.0

RUN yum install -y java-1.7.0-openjdk nginx && yum clean all
# ENV PATH=/opt/rh/devtoolset-3/root/usr/bin:/opt/rh/python27/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/ajava/default/bin:/usr/local/spark/bin:/usr/local/hadoop/bin

COPY ./certs/ /certs/
RUN keytool -import -trustcacerts -file /certs/kinesis.pem -storepass changeit -noprompt -alias localKinesis -keystore $JAVA_HOME/jre/lib/security/cacerts
RUN keytool -import -trustcacerts -file /certs/dynamo.pem  -storepass changeit -noprompt -alias localDynamo  -keystore $JAVA_HOME/jre/lib/security/cacerts


ENV AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
ENV AWS_SECRET_ACCESS_KEY=ZBBBBBBBBBBBBBBBB/ooooooooooooooooooooo0

RUN echo "log4j.logger.com.amazonaws.services.kinesis.metrics.impl=ERROR" >> /usr/local/spark/conf/log4j.properties

RUN rm /etc/nginx/conf.d/*.conf
COPY ./cluster-nginx.conf /etc/nginx/conf.d/cluster-nginx.conf

EXPOSE 8080 8081 8088 8042 4040 443 80

COPY ./start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]



