FROM objectrocket/mq-base
MAINTAINER Rackspace <cbdteam@rackspace.com>

EXPOSE 9093
ENV MAVEN_CENTRAL="https://repo1.maven.org/maven2" \
	DEBEZIUM_VERSION=0.2.2 \
    KAFKA_HOME="/opt/kafka" \
    KAFKA_CONNECT_PLUGINS_DIR=$KAFKA_HOME/driver

RUN mkdir $KAFKA_HOME &&\
    cd $KAFKA_HOME &&\
    mkdir $KAFKA_CONNECT_PLUGINS_DIR &&\
    chmod -R 755 $KAFKA_HOME

WORKDIR /tmp
ADD create-image.sh /tmp/
RUN /tmp/create-image.sh
COPY log4j.properties $KAFKA_HOME/config/log4j.properties
COPY docker-entrypoint.sh /

RUN curl -fSL -o /tmp/plugin.tar.gz \
                 $MAVEN_CENTRAL/io/debezium/debezium-connector-mysql/$DEBEZIUM_VERSION/debezium-connector-mysql-$DEBEZIUM_VERSION-plugin.tar.gz &&\
    tar -xzf /tmp/plugin.tar.gz -C $KAFKA_CONNECT_PLUGINS_DIR &&\
    rm -f /tmp/plugin.tar.gz

VOLUME ["/kafka/data","/kafka/logs","/kafka/config"]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
