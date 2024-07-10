import os
import sys

from pika import (
    BlockingConnection, ConnectionParameters
)


def callback(channel, method, properties, body):
    print(f" [x] Received {body}")


def main():
    parameters = ConnectionParameters("rabbitmq")
    connection = BlockingConnection(parameters)
    channel = connection.channel()

    channel.queue_declare(queue='hello')

    channel.basic_consume(
        queue="hello",
        auto_ack=True,
        on_message_callback=callback
    )
    print(" [*] Waiting for messages. To exit press Ctrl+C")
    channel.start_consuming()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
