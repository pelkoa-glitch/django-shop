MANAGE_PY = python manage.py
DC = docker compose
EXEC = docker exec -it
LOGS = docker logs
ENV = --env-file .env
APP_CONTAINER = django-shop
DB_CONTAINER = django-shop-db
RABBIT_CONTAINER = shop-rabbitmq
CELERY_CONTAINER = shop-celery
FLOWER_CONTAINER = flower
APP_FILE = docker_compose/app.yaml
STORAGES_FILE = docker_compose/storages.yaml
RABBIT_FILE = docker_compose/rabbitmq.yaml
CELERY_FILE = docker_compose/celery.yaml
FLOWER_FILE = docker_compose/flower.yaml
CELERY_LOCAL_RUN = celery -A django_shop worker -l info
CELERY_LOCAL_RUN_FLOWER = celery -A django_shop flower


#local commands
.PHONY: run
run:
	${MANAGE_PY} runserver

.PHONY: celery-local
celery-local:
	${CELERY_LOCAL_RUN}

.PHONY: flower-local
flower-local:
	${CELERY_LOCAL_RUN_FLOWER}

.PHONY: migrations-local
migrations-local:
	${MANAGE_PY} makemigrations

.PHONY: migrate-local
migrate-local:
	${MANAGE_PY} migrate


# up containers

.PHONY: all
all:
	${DC} -f ${APP_FILE} ${env} -f ${STORAGES_FILE} ${ENV} -f ${RABBIT_FILE} ${ENV} -f ${CELERY_FILE} ${ENV} -f ${FLOWER_FILE} ${ENV} up --build -d

.PHONY: all-down
all-down:
	${DC} -f ${APP_FILE} ${env} -f ${STORAGES_FILE} ${ENV} -f ${RABBIT_FILE} ${ENV} -f ${CELERY_FILE} ${ENV} -f ${FLOWER_FILE} ${ENV} down

.PHONY: app
app:
	${DC} -f ${APP_FILE} ${env} -f ${STORAGES_FILE} ${ENV} -f ${RABBIT_FILE} ${ENV} up --build -d

.PHONY: app-logs
app-logs:
	${LOGS} ${APP_CONTAINER} -f

.PHONY: app-down
app-down:
	${DC} -f ${APP_FILE} ${env} -f ${STORAGES_FILE} ${ENV} -f ${RABBIT_FILE} ${ENV} down

.PHONY: storages
storages:
	${DC} -f ${STORAGES_FILE} ${ENV} up -d

.PHONY: storages-logs
storages-logs:
	${LOGS} ${DB_CONTAINER} -f

.PHONY: storages-down
storages-down:
	${DC} -f ${STORAGES_FILE} ${ENV} down

.PHONY: celery
celery:
	${DC} -f ${CELERY_FILE} up -d

.PHONY: celery-logs
celery-logs:
	${LOGS} ${CELERY_CONTAINER} -f

.PHONY: celery-down
celery-down:
	${DC} -f ${CELERY_FILE} down

.PHONY: flower
flower:
	${DC} -f ${FLOWER_FILE} up -d

.PHONY: flower-logs
flower-logs:
	${LOGS} ${FLOWER_CONTAINER} -f

.PHONY: flower-down
flower-down:
	${DC} -f ${FLOWER_FILE} down


.PHONY: rabbitmq
rabbitmq:
	${DC} -f ${RABBIT_FILE} ${ENV} up -d

.PHONY: rabbitmq-logs
rabbitmq-logs:
	${LOGS} ${RABBIT_CONTAINER} -f

.PHONY: rabbitmq-down
rabbitmq-down:
	${DC} -f ${RABBIT_FILE} ${ENV} down

# Django commands
.PHONY: migrate
migrate:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} migrate

.PHONY: makemigrations
makemigrations:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} makemigrations

.PHONY: superuser
superuser:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} createsuperuser

.PHONY: collectstatic
collectstatic:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} collectstatic

.PHONY: run-test
run-test:
	${EXEC} ${APP_CONTAINER} pytest

.PHONY: console-mainapp
console-mainapp:
	${EXEC} ${APP_CONTAINER} ash
