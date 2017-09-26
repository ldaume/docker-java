FROM frolvlad/alpine-glibc:alpine-3.6

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=144 \
    JAVA_BUILD=01 \
    JAVA_HOME=/usr/lib/jvm/current-java

RUN apk update && apk upgrade && apk add wget ca-certificates


RUN cd /tmp \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
      "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/090f390dda5b47b9b721c7dfaa008135/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
      -P /tmp \
    && tar xzf "/tmp/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" -C /tmp \
    && mkdir -p /usr/lib/jvm && mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
    && ln -s "java-${JAVA_VERSION}-oracle" $JAVA_HOME \
    && ln -s "$JAVA_HOME/bin/"* "/usr/bin/" \
    && rm -rf $JAVA_HOME/*.txt \
    && rm -rf $JAVA_HOME/*.html \
    && apk del wget ca-certificates \
    && rm /tmp/*
