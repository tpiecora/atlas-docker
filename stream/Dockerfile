FROM centos:7
MAINTAINER "Ted Piecora" <tpiecora@gmail.com>
LABEL version="0.1"
LABEL description="stream service for atlas"

#RUN yum install -y centos-release-scl && yum clean all
#RUN yum install -y devtoolset-3-gcc-c++ python27 && yum clean all
RUN curl -sL https://rpm.nodesource.com/setup_5.x | bash - && yum install -y nodejs && yum clean all
#RUN scl enable python27 devtoolset-3 "npm install kinesalite"
RUN npm install kinesalite
COPY ./start.sh /etc/start.sh
RUN chmod 755 /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]