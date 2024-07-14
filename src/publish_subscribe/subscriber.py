import sys
import os
from pika import BlockingConnection, ConnectionParameters


def main():
    EXCHANGE_NAME = "logs"

    parameters = ConnectionParameters(host="rabbitmq")
    connection = BlockingConnection(parameters)
    channel = connection.channel()

    channel.exchange_declare(exchange=EXCHANGE_NAME, exchange_type="fanout")

    result = channel.queue_declare(queue="", exclusive=True)

    queue_name = result.method.queue

    channel.queue_bind(exchange=EXCHANGE_NAME, queue=queue_name)

    print(" [x] Waiting for logs. To exit press Ctrl+C")

    def callback(channel, method, properties, body):
        print(f" [x] {body.decode()}")

    consumer_parameters = {
        "queue": queue_name,
        "on_message_callback": callback,
        "auto_ack": True
    }
    channel.basic_consume(**consumer_parameters)

    channel.start_consuming()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
