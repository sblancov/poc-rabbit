.PHONY: docker-build
docker-build:
	docker build -t poc-rabbit:latest -f environments/development/Dockerfile .

.PHONY: docker-create-network
docker-create-network:
	docker network create poc-rabbit-network
