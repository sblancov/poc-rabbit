import os
import sys
from pika import BlockingConnection, ConnectionParameters


EXCHANGE_NAME = "topic_logs"
EXCHANGE_TYPE = "topic"


def callback(channel, method, properties, body):
    print(f" [x] {method.routing_key}:{body.decode()}")


def main():
    parameters = ConnectionParameters(host="rabbitmq")
    connection = BlockingConnection(parameters=parameters)
    channel = connection.channel()
    channel.exchange_declare(
        exchange=EXCHANGE_NAME,
        exchange_type=EXCHANGE_TYPE
    )
    result = channel.queue_declare("", exclusive=True)
    queue_name = result.method.queue
    binding_keys = sys.argv[1:]
    if not binding_keys:
        sys.stderr.write(f"Usage: {sys.argv[0]} [bingding_keys]...\n")
        sys.exit(1)
    for binding_key in binding_keys:
        channel.queue_bind(
            exchange=EXCHANGE_NAME,
            queue=queue_name,
            routing_key=binding_key
        )

    print(f" [x] Waiting for logs. To exit press Ctrl+C")

    channel.basic_consume(
        queue=queue_name,
        on_message_callback=callback,
        auto_ack=True
    )
    channel.start_consuming()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
