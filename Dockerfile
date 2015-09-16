#Logstash version 1.5.4

FROM fedora:21

MAINTAINER Yury Kavaliou <Yury_Kavaliou@epam.com>

ENV LOGSTASH_VERSION 1.5.4

RUN yum install -y java \
    tar

WORKDIR /tmp
ADD https://download.elasticsearch.org/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz logstash.tar.gz

RUN tar xzf logstash.tar.gz \
    && mv logstash-$LOGSTASH_VERSION /opt/logstash \
    && rm logstash.tar.gz

WORKDIR /
COPY logstash_start.sh /usr/local/sbin/logstash_start.sh
RUN chmod 700 /usr/local/sbin/logstash_start.sh

ENTRYPOINT ["/bin/bash", "/usr/local/sbin/logstash_start.sh"]

VOLUME /var/log
VOLUME /var/run
