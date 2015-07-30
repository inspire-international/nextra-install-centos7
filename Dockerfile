FROM            centos:centos7
MAINTAINER      Norio ISHIZAKI
ENV             container       docker

RUN yum update -y  systemd
RUN yum install -y  initscripts
RUN yum install -y  httpd

EXPOSE          80
EXPOSE          39001
EXPOSE          39002

RUN yum install -y vim
RUN yum install -y cronie
RUN yum install -y rsyslog
RUN yum install -y sudo
RUN yum install -y php
RUN yum install -y wget
RUN yum install -y python-setuptools
RUN easy_install supervisor

RUN systemctl enable httpd
RUN systemctl enable crond
RUN systemctl enable rsyslog

RUN yum install -y gcc make ksh
RUN yum -y install java-1.8.0-openjdk-devel.x86_64

RUN wget http://www.inspire-intl.com/product/nextra/download/nextra-6.1.0.0-install-centos7.x86_64.tgz -O /tmp/nextra-6.1.0.0-install-centos7.x86_64.tgz
RUN mkdir -p /home/nextra
RUN tar xvfz /tmp/nextra-6.1.0.0-install-centos7.x86_64.tgz -C /home/nextra

ENV ODEDIR /home/nextra/tcp
ENV PATH "$PATH:$ODEDIR/bin:$ODEDIR/../cmn/bin"
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.51-1.b16.el7_1.x86_64
ENV LD_LIBRARY_PATH "$JAVA_HOME/jre/lib/amd64/server:$ODEDIR/lib"

ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
