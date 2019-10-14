FROM postgres:10.10-alpine
MAINTAINER mnforlenza

ENV POSTGRES_USER jumahuaca  
ENV POSTGRES_PASSWORD jumahuaca.0  
ENV POSTGRES_DB jumahuaca_uva_loan

ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u222
ENV JAVA_ALPINE_VERSION 8.222.10-r0


RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

# Maven
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://ftp.fau.de/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION /usr/lib/mvn
    
RUN mkdir -p /usr/app    
    
RUN wget https://github.com/jumahuaca/jumahuaca-core/archive/master.zip && \
	unzip master.zip && \
	rm master.zip && \
	mv jumahuaca-core-master /usr/app

RUN wget https://github.com/jumahuaca/jumahuaca-dropwizard-example/archive/master.zip && \
	unzip master.zip && \
	rm master.zip && \
	mv jumahuaca-dropwizard-example-master /usr/app
	
    
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh 

ADD run.sh /usr/app/run.sh

RUN chmod 777 /usr/app/run.sh

WORKDIR /usr/app

EXPOSE 8080
    
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["./run.sh"]
