# Hello world

## Schema

```mermaid
flowchart LR
    Producer --> Queue
    Queue --> Consumer
```

## Running

On one shell execute:

    make run-receive

First the receiver because there will be something which will
receive the messages sent by the other process.

On other shell execute:

    make run-send

You can execute multiple times the send process, to see multiple
messages received in the receive process shell.


## References

* https://www.rabbitmq.com/tutorials/tutorial-one-python
