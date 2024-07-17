# Rabbit PoC

This project aims to know a little better a useful tool called
RabbitMQ. It can be use to follow some patterns easily:
- [Producer Consumer](https://en.wikipedia.org/wiki/Producer%E2%80%93consumer_problem)
- [Publish Subscribe](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern)
- [Master Slave](https://en.wikipedia.org/wiki/Master%E2%80%93slave_(technology))

RabbitMQ is distributed and scalable.

I recommend to follow the tutorial of the official webpage.
It is a great started point.

This project can be useful for you to test RabbitMQ running
everything in Docker. Then, you do not need to install anything
more than Docker. Enjoy!


## Run PoC locally

First of all, we need our base image built. So:

   make docker-build

After that, we now can run our test scripts. But there is no
connection with RabbitMQ server. So:

    make docker-create-network

With this command we have created the network we will use to
connect all our scripts and RabbitMQ.

Now, we need RabbitMQ server running, so:

    make run-rabbit

And that is almost all, we can run all examples following the
appropriate steps in each README.md:

* [Hello World](./src/hello_world/README.md)
* [Work Queues](./src/work_queues/README.md)
* [Publish Subscribe](./src/publish_subscribe/README.md)
* [Routing](./src/routing/README.md)
* [Topics](./src/topics/README.md)
* [RPC](./src/rpc/README.md)


## More info

You can see the stats of RabbitMQ using the web interface:

    http://localhost:15672/

Just, use the default credentials:

    guest:guest


## References

* [DockerHub RabbitMQ image](https://hub.docker.com/_/rabbitmq/)
* [Hello World tutorial](https://www.rabbitmq.com/tutorials/tutorial-one-python)
