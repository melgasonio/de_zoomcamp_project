# --- LOCAL / DEV ENVIRONMENT ---
local-up:
	docker compose \
  	--env-file .env.local \
  	-f docker/dev/docker-compose.dev.yml up -d --build

local-down:
	docker compose \
  	-f docker/dev/docker-compose.dev.yml down -v 

prod-up:
	docker compose \
  	--env-file .env \
  	-f docker/prod/docker-compose.prod.yml up -d --build

prod-down:
	docker compose \
  	-f docker/prod/docker-compose.prod.yml down -v

# --- TERRAFORM SETUP ---
terraform-init:
	docker compose \
	--env-file .env \
	-f docker/prod/docker-compose.prod.yml \
	run --rm terraform init

terraform-plan:
	docker compose \
	--env-file .env \
	-f docker/prod/docker-compose.prod.yml \
	run --rm terraform plan

terraform-apply:
	docker compose \
	--env-file .env \
	-f docker/prod/docker-compose.prod.yml \
	run --rm terraform apply

terraform-destroy:
	docker compose \
	--env-file .env \
	-f docker/prod/docker-compose.prod.yml \
	run --rm terraform destroy