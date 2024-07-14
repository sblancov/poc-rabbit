import os
import sys
from pika import BlockingConnection, ConnectionParameters


EXCHANGE_NAME="direct_logs"


def callback(channel, method, properties, body):
    print(f" [x] {method.routing_key}:{body.decode()}")


def main():
    parameters = ConnectionParameters(host="rabbitmq")
    connection = BlockingConnection(parameters)
    channel = connection.channel()
    channel.exchange_declare(
        exchange=EXCHANGE_NAME,
        exchange_type="direct"
    )
    result = channel.queue_declare(queue="", exclusive=True)
    queue_name = result.method.queue

    severities = sys.argv[1:]
    if not severities:
        sys.stderr.write(f"Usage {sys.argv[0]} [info] [warning] [error]\n")
        sys.exit(1)

    for severity in severities:
        channel.queue_bind(
            exchange=EXCHANGE_NAME,
            queue=queue_name,
            routing_key=severity
        )

    print(f" [*] Waiting for logs. To exit press Ctrl+C")

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
