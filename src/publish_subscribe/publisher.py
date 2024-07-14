from pika import BlockingConnection, ConnectionParameters
import sys


EXCHANGE_NAME = "logs"

parameters = ConnectionParameters(host="rabbitmq")
connection = BlockingConnection(parameters)

channel = connection.channel()
channel.exchange_declare(exchange=EXCHANGE_NAME, exchange_type="fanout")

message = " ".join(sys.argv[1:]) or "info: Hello World!"
channel.basic_publish(exchange=EXCHANGE_NAME, routing_key="", body=message)

print(f" [x] Sent {message}")

connection.close()
