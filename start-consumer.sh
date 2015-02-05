#!/bin/bash

OPTS=`getopt -o ekq: --long rmq-host,rmq-port,rmq-user,rmq-pass,pref-count,vhost,es-host,es-index: -n 'parse-options' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

EXCHANGE="amq.topic"
RMQ_HOST="localhost"
RMQ_PORT=5672
RMQ_USER="rabbit"
RMQ_PASS="rabbit"
ROUTING_KEY="mqtt.device.*"
PREFETCH_COUNT=256
QUEUE_NAME="ha.mqtt.consumer"
VHOST="/"
ES_HOST="localhost"
ES_INDEX="cars"

while true; do
    case "$1" in
        --rmq-host ) RMQ_HOST="$2"; shift; shift ;;
        --rmq-port ) RMQ_PORT="$2"; shift; shift ;;
        --rmq-user ) RMQ_USER="$2"; shift; shift ;;
        --rmq-pass ) RMQ_PASS="$2"; shift; shift ;;
        --pref-count ) PREFETCH_COUNT="$2"; shift; shift ;;
        --vhost ) VHOST="$2"; shift; shift ;;
        --es-host ) ES_HOST="$2"; shift; shift ;;
        --es-index ) ES_INDEX="$2"; shift; shift ;;
        -e ) EXCHANGE="$2"; shift; shift ;;
        -k ) ROUTING_KEY="$2"; shift; shift ;;
        -q ) QUEUE_NAME="$2"; shift; shift ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

LOGSTASH_PATH="/opt/logstash/"

# Sets logstash config
cat > ${LOGSTASH_PATH}consuming.config <<EOF
    input {
        rabbitmq {
            ack => true
            durable => true
            host => "$RMQ_HOST"
            port => $RMQ_PORT
            user => "$RMQ_USER"
            password => "$RMQ_PASS"
            exchange => "$EXCHANGE"
            queue => "$QUEUE_NAME"
            key => "$ROUTING_KEY"
            prefetch_count => $PREFETCH_COUNT
            vhost => "$VHOST"
        }
    }
    output {
        elasticsearch {
            host => "$ES_HOST"
            index => "$ES_INDEX"
        }
    }
EOF

${LOGSTASH_PATH}bin/logstash -f ${LOGSTASH_PATH}consuming.config

exit 0
