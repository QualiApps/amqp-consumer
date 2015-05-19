#!/bin/bash

LOGSTASH_PATH="/opt/logstash"

# Write logstash config
cat > ${LOGSTASH_PATH}/consume.conf <<EOF
    input {
        rabbitmq {
            ack => true
            durable => true
            host => "${FEED_NAME:-feed}"
            port => ${FEED_PORT:-5672}
            user => "$RMQ_USER"
            password => "$RMQ_PASS"
            exchange => "$RMQ_EXCHANGE"
            queue => "$RMQ_QUEUE_NAME"
            key => "$RMQ_ROUTING_KEY"
            prefetch_count => $RMQ_PREFETCH_COUNT
            vhost => "$RMQ_VHOST"
        }
    }
    output {
        elasticsearch {
            host => "${ES_NAME:-db}"
            protocol => "$ES_PROTOCOL"
            port => $ES_PORT
            index => "$ES_INDEX"
        }
    }
EOF

${LOGSTASH_PATH}/bin/logstash -f ${LOGSTASH_PATH}/consume.conf $@

