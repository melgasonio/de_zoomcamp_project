local up:
	docker compose \
  	--env-file .env.local \
  	-f docker/dev/docker-compose.dev.yml up -d

local down:
	docker compose \
  	-f docker/dev/docker-compose.dev.yml down -v

prod up:
	docker compose \
  	--env-file .env \
  	-f docker/prod/docker-compose.prod.yml up -d

prod down:
	docker compose \
  	-f docker/prod/docker-compose.prod.yml down -v