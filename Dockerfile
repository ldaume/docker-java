#FROM frolvlad/alpine-glibc:alpine-3.6
FROM debian:sid-slim

ENV JAVA_VERSION=9 \
    JAVA_UPDATE=ea \
    JAVA_BUILD=181 \
    JAVA_HOME=/usr/lib/jvm/current-java

RUN apt-get update && apt-get upgrade -y && apt-get install wget ca-certificates -y

RUN cd /tmp
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+${JAVA_BUILD}/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
    -P /tmp
RUN tar xzf "/tmp/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" -C /tmp
RUN pwd
RUN ls -al /tmp
RUN mkdir -p /usr/lib/jvm && mv "/tmp/jdk-${JAVA_VERSION}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle"
RUN ln -s "java-${JAVA_VERSION}-oracle" $JAVA_HOME
RUN ln -s "$JAVA_HOME/bin/"* "/usr/bin/"
RUN rm -rf $JAVA_HOME/*.txt
RUN rm -rf $JAVA_HOME/*.html
RUN apt-get remove wget ca-certificates -y
RUN rm /tmp/*
