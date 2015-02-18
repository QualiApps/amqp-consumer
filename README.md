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

`docker run -d -P --name logstash qapps/amqp-consumer [options]`

