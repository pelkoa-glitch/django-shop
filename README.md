# Django Online Store

### A simple django e-commerce website where you can:

* Select products
* add them to your cart 
* make a purchase by paying with a credit card

## Requirements

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [GNU Make](https://www.gnu.org/software/make/)
- [POETRY](https://python-poetry.org/)

## How to Use

1. **Clone the repository:**

   ```bash
       git clone https://github.com/pelkoa-glitch/django-shop.git
2. Install all required packages in `Requirements` section.

3. Rename and fill the file `.env.example` with your dependencies.

4. Run commands:
    ```bash
        cd django-shop  -  go to project folder
        poetry install  -  install dependencies
        poetry shell    -  activate python venv
        make app        -  up application, database and rabbitmq
        make celery     -  up celery container
        make flower     -  up flower container
5. Go to http://0.0.0.0:8000 and enjoy the app

6. Also rabbit management will be on http://127.0.0.1:15672,
    flower(celery workers) will be on http://127.0.0.1:5555

### Implemented Commands

* `make app` - up application and database/infrastructure
* `make app-logs` - follow the logs in app container
* `make app-down` - down application and all infrastructure
* `make storages` - up only storages. you should run your application locally for debugging/developing purposes
* `make storages-logs` - follow the logs in storages container
* `make storages-down` - down all infrastructure
* `make celery` - up celery container
* `make celery-logs` - follow the logs in celery container
* `make celery-down` - down celery container
* `make flower` - up flower container
* `make flower-logs` - follow the logs in flower container
* `make flower-down` - down flower container
* `make rabbitmq` - up rabbitmq container
* `make rabbitmq-logs` - follow the logs in rabbitmq container
* `make rabbitmq-down` - down rabbitmq container

### Most Used Django Specific Commands

* `make makemigrations` - make migrations to models
* `make migrate` - apply all made migrations
* `make collectstatic` - collect static
* `make superuser` - create admin user
* `console-mainapp` - open console in 'main app' container
