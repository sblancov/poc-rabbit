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

.PHONY: rabbit-list-queues
rabbit-list-queues:
	docker exec -it rabbitmq rabbitmqctl list_queues


# Others

.PHONY: run-send
run-send:
	@docker run \
		--rm \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python hello_world/send.py
