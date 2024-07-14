# Docker

.PHONY: docker-build
docker-build:
	docker build -t poc-rabbit:latest -f environments/development/Dockerfile .

.PHONY: docker-create-network
docker-create-network:
	docker network create poc-rabbit-network


# Rabbit

.PHONY: rabbit-run
rabbit-run:
	docker run \
		-d \
		--rm \
		--network poc-rabbit-network \
		--name rabbitmq \
		-p 5672:5672 \
		-p 15672:15672 \
		rabbitmq:3.13-management

.PHONY: rabbit-stop
rabbit-stop:
	docker stop \
		rabbitmq

.PHONY: rabbit-list-queues
rabbit-list-queues:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_queues

.PHONY: rabbit-messages-unacknowledged
rabbit-messages-unacknowledged:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_queues name messages_ready messages_unacknowledged


.PHONY: rabbit-list-exchanges
rabbit-list-exchanges:
	docker exec \
		-it \
		rabbitmq \
		rabbitmqctl list_exchanges

# Hello World

.PHONY: run-send
run-send:
	@docker run \
		--rm \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python hello_world/send.py

.PHONY: run-receive
run-receive:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python hello_world/receive.py


# Work Queues

.PHONY: run-new-task
run-new-task:
	@docker run \
		--rm \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python work_queues/new_task.py

.PHONY: run-multiple-new-task
run-multiple-new-task:
	@$(foreach i, $(shell seq 10), \
		docker run \
			--rm \
			-v $(PWD)/src:/app/ \
			--network poc-rabbit-network \
			poc-rabbit \
			python work_queues/new_task.py;)

.PHONY: run-worker
run-worker:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python work_queues/worker.py


# Publish Subscribe

.PHONY: run-publisher
run-publisher:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python publish_subscribe/publisher.py

.PHONY: run-subscriber
run-subscriber:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python publish_subscribe/subscriber.py
