.PHONY: help tf-init tf-plan tf-apply tf-fmt lint test

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

ENV ?= dev

tf-init: ## Run terraform init for ENV (default: dev)
	cd terraform/projects/$(ENV) && terraform init

tf-plan: ## Run terraform plan for ENV (default: dev)
	cd terraform/projects/$(ENV) && terraform plan -var-file="$(ENV).tfvars"

tf-apply: ## Run terraform apply for ENV (default: dev)
	cd terraform/projects/$(ENV) && terraform apply -var-file="$(ENV).tfvars"

tf-fmt: ## Format all Terraform files
	terraform fmt -recursive terraform/

lint: ## Lint Python code with ruff
	ruff check shared/ azure-ml/

test: ## Run Python tests
	pytest tests/ -v
