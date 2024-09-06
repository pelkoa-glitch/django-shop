MANAGE_PY = python manage.py
DC = docker compose
EXEC = docker exec -it
LOGS = docker logs
ENV = --env-file .env
APP_CONTAINER = django-shop
DB_CONTAINER = django-shop-db
RABBIT_CONTAINER = shop-rabbinmq
APP_FILE = docker_compose/app.yaml
STORAGES_FILE = docker_compose/storages.yaml
RABBIT_FILE = docker_compose/rabbitmq.yaml



#local commands
.PHONY: run
run:
	${MANAGE_PY} runserver

.PHONY: migrations
migrations:
	${MANAGE_PY} makemigrations

.PHONY: migrate
migrate:
	${MANAGE_PY} migrate


# container commands
#TODO: add deploying commands