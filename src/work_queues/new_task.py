import sys
from pika import (
    BlockingConnection, ConnectionParameters, BasicProperties, DeliveryMode
)

parameters = ConnectionParameters('rabbitmq')
connection = BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)

message = ' '.join(sys.argv[1:]) or "Hello World!..."
channel.basic_publish(
    exchange="",
    routing_key="task_queue",
    body=message,
    properties=BasicProperties(
        delivery_mode = DeliveryMode.Persistent
    )
)
print(f" [x] Sent {message}")

connection.close()
