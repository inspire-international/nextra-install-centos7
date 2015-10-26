FROM            centos:centos7
MAINTAINER      Norio ISHIZAKI
ENV             container       docker

RUN yum update -y  systemd
RUN yum install -y  initscripts
RUN yum install -y  httpd

EXPOSE          8080

RUN yum install -y vim
RUN yum install -y cronie
RUN yum install -y rsyslog
RUN yum install -y sudo
RUN yum install -y php
RUN yum install -y wget
RUN yum install -y python-setuptools
RUN yum install -y unzip
RUN easy_install supervisor

RUN systemctl enable httpd
RUN systemctl enable crond
RUN systemctl enable rsyslog

# Download and deploy gradle to /opt/gradle-2.8
RUN wget https://services.gradle.org/distributions/gradle-2.8-bin.zip -O /tmp/gradle-2.8-bin.zip
RUN unzip /tmp/gradle-2.8-bin.zip -d /opt
ENV GRADLE_HOME /opt/gradle-2.8

RUN yum install -y gcc make ksh

# JDK1.8
RUN yum -y install java-1.8.0-openjdk-devel.x86_64
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
RUN yum install -y ant swig
RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
	update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
	update-alternatives --set java "${JAVA_HOME}/bin/java" && \
	update-alternatives --set javaws "${JAVA_HOME}/bin/javaws" && \
	update-alternatives --set javac "${JAVA_HOME}/bin/javac"

# Nextra65
RUN wget http://www.inspire-intl.com/product/nextra/download/nextra-65.tgz -O /tmp/nextra-65.tgz
RUN mkdir -p /home/nextra/build
RUN tar xvfz /tmp/nextra-65.tgz -C /home/nextra/build
ENV MODULE_BUILD_TYPE R
ENV ODEDIR /home/nextra/build/Nextra/src/../install/linux.x86_64/tcp
ENV PATH "$PATH:$ODEDIR/bin:$ODEDIR/../cmn/bin"
ENV LD_LIBRARY_PATH "$JAVA_HOME/jre/lib/amd64/server:$ODEDIR/lib"
RUN cd /home/nextra/build/Nextra/src && ./build.sh all
RUN cd /home/nextra/build/Nextra/src && ./build.sh install
RUN cd $ODEDIR/../samples/nextra-rest-server/java/standard && ./build.sh

ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
