import sys
import uuid
from pika import BlockingConnection, ConnectionParameters, BasicProperties


QUEUE_NAME = "rpc_queue"


class FibonacciRpcClient:
    def __init__(self) -> None:
        parameters = ConnectionParameters(host="rabbitmq")
        self.connection = BlockingConnection(parameters=parameters)
        self.channel = self.connection.channel()
        result = self.channel.queue_declare(queue="", exclusive=True)
        self.callback_queue = result.method.queue
        self.channel.basic_consume(
            queue=self.callback_queue,
            on_message_callback=self.on_response,
            auto_ack=True
        )
        self.response = None
        self.correlation_id = None

    def on_response(self, channel, method, props, body):
        if self.correlation_id == props.correlation_id:
            self.response = body

    def call(self, n:int):
        self.response = None
        self.correlation_id = str(uuid.uuid4())
        self.channel.basic_publish(
            exchange="",
            routing_key=QUEUE_NAME,
            properties=BasicProperties(
                reply_to=self.callback_queue,
                correlation_id=self.correlation_id
            ),
            body=str(n)
        )
        while self.response is None:
            self.connection.process_data_events(time_limit=None)
        return int(self.response)


def main():
    n = sys.argv[1]
    number = int(n)
    fibonacci_rpc = FibonacciRpcClient()
    print(f" [x] requesting fib({number})")
    response = fibonacci_rpc.call(int(number))
    print(f" [.] Got {response}")


if __name__ == "__main__":
    main()
