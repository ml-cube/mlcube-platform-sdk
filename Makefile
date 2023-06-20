ifdef OS
   export PYTHON_COMMAND=python
else
   export PYTHON_COMMAND=python3.8
endif


setup:
	$(PYTHON_COMMAND) -m pip install poetry
	poetry env use $(PYTHON_COMMAND)
	poetry run pip install --upgrade pip
	cp .hooks/pre-commit .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
	cp .hooks/pre-push .git/hooks/pre-push && chmod +x .git/hooks/pre-push
	cp .hooks/post-merge .git/hooks/post-merge && chmod +x .git/hooks/post-merge

install:
	poetry lock
	poetry install

isort:
	poetry run isort --skip-glob=.tox .

format:
	poetry run black mlcube_platform_sdk

lint:
	poetry run pylint  --extension-pkg-whitelist='pydantic' mlcube_platform_sdk
	poetry run flake8 mlcube_platform_sdk
	poetry run mypy --ignore-missing-imports --install-types --non-interactive --package mlcube_platform_sdk

test:
	poetry run pytest --verbose --color=yes --cov=mlcube_platform_sdk

env:
	poetry shell

requirements:
	poetry export --without-hashes --with-credentials -f requirements.txt

class-diagram:
	poetry run pyreverse -o svg --colorized --module-names y --all-ancestors mlcube_platform_sdk

all: format isort lint test