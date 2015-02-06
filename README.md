AMQP consumer
==============
Logstash as a consumer (input - RabbitMQ, output - ElasticSearch)

Installation
--------------

1. Install [Docker](https://www.docker.com)

2. Download automated build from public Docker Hub Registry: `docker pull qapps/amqp-consumer`
(alternatively, you can build an image from Dockerfile: `docker build -t="qapps/amqp-consumer" github.com/qualiapps/amqp-consumer`)

Running the daemon
-----------------

`docker run -d -P --name consumer qapps/amqp-consumer [options]`

options:

`--rmq-host` - rabbitmq IP-address (default - 127.0.0.1)

`--rmq-port` - rabbitmq port (default - 5672)

`--rmq-user` - rabbitmq user (default - "rabbit")

`--rmq-pass` - rabbitmq password (default - "rabbit")

`--pref-count` - limit the number of unacknowledged messages on a channel (default - 256)

`--vhost` - rabbitmq virtual host (default - "/")

`--es-host` - elasticsearch IP-address (defaul - 127.0.0.1)

`--es-index` - elasticsearch index (default - "cars")

`-e` - the name of the exchange to bind the queue to (default - "amq.topic")

`-k` - the routing key to use when binding a queue to the exchange (default - "mqtt.device.*")

`-q` - query name (default - "ha.mqtt.consumer")
