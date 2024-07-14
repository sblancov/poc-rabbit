# Work Queues

On one shell, execute:

    make run-worker

This is a worker, which is listening to receive a job to do.

On other shell, execute:

    make run-new-task

This create a new task to any worker will do.

More workers, more fun!
Open multiple shells to create more workers and execute again:

    make run-worker

Then, in other shell:

    make run-multiple-new-task

This runs 10 tasks, and all workers receives in order to finish the work.


## References

* https://www.rabbitmq.com/tutorials/tutorial-two-python
