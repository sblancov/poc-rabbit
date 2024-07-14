import sys

from pika import BlockingConnection, ConnectionParameters


EXCHANGE_NAME = "topic_logs"
EXCHANGE_TYPE = "topic"


def main():
    parameters = ConnectionParameters(host="rabbitmq")
    connection = BlockingConnection(parameters)
    channel = connection.channel()
    channel.exchange_declare(
        exchange=EXCHANGE_NAME,
        exchange_type=EXCHANGE_TYPE
    )
    routing_key = sys.argv[1] if len(sys.argv) > 1 else "anonymous.info"
    message = "".join(sys.argv[2:]) or "Hello World!"
    channel.basic_publish(
        exchange=EXCHANGE_NAME,
        routing_key=routing_key,
        body=message
    )

    print(f" [x] Sent {routing_key}:{message}")

    connection.close()


if __name__ == "__main__":
    main()
