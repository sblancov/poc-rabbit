# Routing

This example is a little more complex. We need 2 publishers and 3 consumers to
see what happens here.

So, before to run publishers, it is convenient to run subscribers, then the
publishers. Execute each of these command on a different shell:

    make run-subscriber-warning-only
    make run-subscriber-error-only
    make run-subscriber-error-warning
    make run-publisher-warning
    make run-publisher-error

When a warning is sent from any publisher, the subscriber-warning and
subscriber-error-warning will show a message.
When a error is sent from any publisher, the subscriber-error and
subscriber-error-warning will show a message.


## References

* https://www.rabbitmq.com/tutorials/tutorial-four-python
