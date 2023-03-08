PROJECT_NAME := "excalidraw"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Setup required things
	python3 -m pip install -U -r requirements-dev.txt
	pre-commit install
	
build-docker: ## Build container
	docker build -t $(PROJECT_NAME):test .

run-docker: build-docker ## Run container
	docker run -p 42069:80 $(PROJECT_NAME):test

pre-commit-all: ## run pre-commit on all files
	pre-commit run --all-files

pre-commit: ## run pre-commit
	pre-commit run
