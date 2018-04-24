#FROM frolvlad/alpine-glibc:alpine-3.6
FROM debian:wheezy-slim


RUN apt-get update && apt-get upgrade -y && apt-get install wget ca-certificates -y

ENV JAVA_VERSION=10.0.1 \
    JAVA_BUILD=10 \
    JAVA_HOME=/usr/lib/jvm/current-java
    
RUN cd /tmp \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
      "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+${JAVA_BUILD}/fb4372174a714e6b8c52526dc134031e/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
      -P /tmp \
    && tar xzf "/tmp/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" -C /tmp \
    && mkdir -p /usr/lib/jvm && mv "/tmp/jdk-${JAVA_VERSION}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
    && ln -s "java-${JAVA_VERSION}-oracle" $JAVA_HOME \
    && ln -s "$JAVA_HOME/bin/"* "/usr/bin/" \
    && rm -rf $JAVA_HOME/*.txt \
    && rm -rf $JAVA_HOME/*.html \
    && apt-get remove wget ca-certificates -y \
    && rm /tmp/*
