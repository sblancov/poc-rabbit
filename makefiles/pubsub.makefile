
.PHONY: pubsub-run-publisher
pubsub-run-publisher:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python publish_subscribe/publisher.py

.PHONY: pubsub-run-subscriber
pubsub-run-subscriber:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python publish_subscribe/subscriber.py
