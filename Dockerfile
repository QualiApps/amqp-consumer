FROM fedora:21

MAINTAINER Yury Kavaliou <test@test.com>

RUN yum install -y java
RUN yum install -y tar
# Download version 1.4.2 of logstash
RUN cd /tmp 
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
RUN tar -xzvf ./logstash-1.4.2.tar.gz
RUN mv ./logstash-1.4.2 /opt/logstash
RUN rm ./logstash-1.4.2.tar.gz

ADD start-consumer.sh /usr/local/sbin/start-consumer.sh

ENTRYPOINT ["/bin/bash", "/usr/local/sbin/start-consumer.sh"]
CMD [""]
