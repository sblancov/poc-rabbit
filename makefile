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


# Routing

.PHONY: run-publisher-error
run-publisher-error:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/publisher.py "error" "Something critical happened!"

.PHONY: run-publisher-warning
run-publisher-warning:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/publisher.py "warning" "Warning! Warning!"

.PHONY: run-subscriber-info-only
run-subscriber-info-only:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/subscriber.py info

.PHONY: run-subscriber-warning-only
run-subscriber-warning-only:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/subscriber.py warning

.PHONY: run-subscriber-error-only
run-subscriber-error-only:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/subscriber.py error

.PHONY: run-subscriber-error-warning
run-subscriber-error-warning:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python routing/subscriber.py error warning


# Topics

.PHONY: run-topics-subscriber-all
run-topics-subscriber-all:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/subscriber.py "#"

.PHONY: run-topics-subscriber-kern
run-topics-subscriber-kern:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/subscriber.py "kern.*"

.PHONY: run-topics-subscriber-critical
run-topics-subscriber-critical:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/subscriber.py "*.critical"

.PHONY: run-topics-publisher-kern-critical
run-topics-publisher-kern-critical:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/publisher.py "kern.critical"

.PHONY: run-topics-publisher-core-critical
run-topics-publisher-core-critical:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/publisher.py "core.critical"

.PHONY: run-topics-publisher-core-warning
run-topics-publisher-core-warning:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python topics/publisher.py "core.warning"
