# Rabbit PoC

This project aims to know a little better a useful tool called
RabbitMQ. It can be use to follow some patterns easily:
- Consumer Producer
- Publish Subscribe

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
appropriate steps in each section.


### Hello world

On one shell execute:

    make run-receive

First the receiver because there will be something which will
receive the messages sent by the other process.

On other shell execute:

    make run-send

You can execute multiple times the send process, to see multiple
messages received in the receive process shell.


## Work Queues

On one shell execute:

    make run-worker

This is a worker, which is listening to receive a job to do.

On other shell execute:

    make run-new-task

This create a new task to any worker will do.

More workers, more fun!
Open multiple shells to create more workers and execute again:

    make run-worker

Then, in other shell:

    make run-multiple-new-task

This runs 10 tasks, and all workers receives in order to finish the work.


## More info

You can see the stats of RabbitMQ using the web interface:

    http://localhost:15672/

Just, use the default credentials:

    guest:guest


## References

* [DockerHub RabbitMQ image](https://hub.docker.com/_/rabbitmq/)
* [Hello World tutorial](https://www.rabbitmq.com/tutorials/tutorial-one-python)
