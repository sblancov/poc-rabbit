from pika import (
    BlockingConnection, ConnectionParameters
)

parameters = ConnectionParameters('rabbitmq')
connection = BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='hello')

channel.basic_publish(
    exchange="",
    routing_key="hello",
    body="Hello World!"
)

print(" [x] Sent 'Hello World!'")

connection.close()
