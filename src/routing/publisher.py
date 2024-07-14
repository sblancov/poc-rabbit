import sys
from pika import BlockingConnection, ConnectionParameters


EXCHANGE_NAME="direct_logs"

parameters = ConnectionParameters(host="rabbitmq")
connection = BlockingConnection(parameters)
channel = connection.channel()
channel.exchange_declare(
    exchange=EXCHANGE_NAME,
    exchange_type="direct"
)

severity = sys.argv[1] if len(sys.argv) > 1 else "info"
message = " ".join(sys.argv[2:]) or "Hello World!"
channel.basic_publish(
    exchange=EXCHANGE_NAME,
    routing_key=severity,
    body=message
)
print(f" [x] Sent {severity}:{message}")

connection.close()
