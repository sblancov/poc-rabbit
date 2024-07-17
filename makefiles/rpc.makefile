.PHONY: run-rpc-server
run-rpc-server:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python rpc/server.py

.PHONY: run-rpc-client
run-rpc-client:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python rpc/client.py 6
