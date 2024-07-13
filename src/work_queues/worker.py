import os
import sys
import time

from pika import (
    BlockingConnection, ConnectionParameters
)


def callback(ch, method, properties, body):
    print(f" [x] Received {body.decode()}")
    time.sleep(body.count(b"."))
    print(f" [x] Done")
    ch.basic_ack(delivery_tag = method.delivery_tag)


def main():
    parameters = ConnectionParameters("rabbitmq")
    connection = BlockingConnection(parameters)
    channel = connection.channel()

    channel.queue_declare(queue='task_queue', durable=True)
    print(" [*] Waiting for messages. To exit press Ctrl+C")

    channel.basic_qos(prefetch_count=2)
    channel.basic_consume(
        queue="task_queue",
        on_message_callback=callback
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
