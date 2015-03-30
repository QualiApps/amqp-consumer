#Logstash version 1.4.2

FROM fedora:21

MAINTAINER Yury Kavaliou <Yury_Kavaliou@epam.com>

ENV LOGSTASH_VERSION 1.4.2

RUN yum install -y java \
    tar

WORKDIR /tmp
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz
RUN tar -xzvf ./logstash-$LOGSTASH_VERSION.tar.gz
RUN mv ./logstash-$LOGSTASH_VERSION /opt/logstash \
RUN rm ./logstash-$LOGSTASH_VERSION.tar.gz

WORKDIR /
COPY logstash_start.sh /usr/local/sbin/logstash_start.sh
RUN chmod 700 /usr/local/sbin/logstash_start.sh

ENTRYPOINT ["/bin/bash", "/usr/local/sbin/logstash_start.sh"]

VOLUME /var/log
VOLUME /var/run

