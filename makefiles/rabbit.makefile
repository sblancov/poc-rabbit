.PHONY: rabbit-rabbit-run
rabbit-rabbit-run:
	docker run \
		-d \
		--rm \
		--network poc-rabbit-network \
		--name rabbitmq \
		-p 5672:5672 \
		-p 15672:15672 \
		rabbitmq:3.13-management

.PHONY: rabbit-rabbit-stop
rabbit-rabbit-stop:
	docker stop \
		rabbitmq

.PHONY: rabbit-rabbit-list-queues
rabbit-rabbit-list-queues:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_queues

.PHONY: rabbit-rabbit-messages-unacknowledged
rabbit-rabbit-messages-unacknowledged:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_queues name messages_ready messages_unacknowledged


.PHONY: rabbit-rabbit-list-exchanges
rabbit-rabbit-list-exchanges:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_exchanges
