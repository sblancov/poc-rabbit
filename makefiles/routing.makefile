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
