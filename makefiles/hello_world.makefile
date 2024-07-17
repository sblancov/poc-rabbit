.PHONY: hello-world-run-send
hello-world-run-send:
	@docker run \
		--rm \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python hello_world/send.py

.PHONY: hello-world-run-receive
hello-world-run-receive:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python hello_world/receive.py
