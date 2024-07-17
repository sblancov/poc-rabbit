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
