from pika import BlockingConnection, ConnectionParameters, BasicProperties


QUEUE_NAME = "rpc_queue"

parameters = ConnectionParameters(host="rabbitmq")
connection = BlockingConnection(parameters=parameters)
channel = connection.channel()
channel.queue_declare(queue=QUEUE_NAME)


def fib(n):
    if n == 0:
        return 1
    elif n == 1:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)


def on_request(channel, method, props, body):
    n = int(body)
    print(f" [.] fib({n})")
    response = fib(n)
    properties = BasicProperties(correlation_id=props.correlation_id)
    channel.basic_publish(
        exchange="",
        routing_key=props.reply_to,
        properties=properties,
        body=str(response)
    )
    channel.basic_ack(delivery_tag=method.delivery_tag)


channel.basic_qos(prefetch_count=1)
channel.basic_consume(
    queue=QUEUE_NAME,
    on_message_callback=on_request
)

print(" [x] Awaiting RPC requests")
channel.start_consuming()
