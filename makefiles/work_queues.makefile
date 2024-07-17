
.PHONY: work-queues-run-new-task
work-queues-run-new-task:
	@docker run \
		--rm \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python work_queues/new_task.py

.PHONY: work-queues-run-multiple-new-task
work-queues-run-multiple-new-task:
	@$(foreach i, $(shell seq 10), \
		docker run \
			--rm \
			-v $(PWD)/src:/app/ \
			--network poc-rabbit-network \
			poc-rabbit \
			python work_queues/new_task.py;)

.PHONY: work-queues-run-worker
work-queues-run-worker:
	@docker run \
		--rm \
		-it \
		-v $(PWD)/src:/app/ \
		--network poc-rabbit-network \
		poc-rabbit \
		python work_queues/worker.py
