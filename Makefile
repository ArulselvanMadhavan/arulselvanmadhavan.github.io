OPAMROOT ?= /lm/users/arul/.opam
OPAMSWITCH ?= default
PORT ?= 3040
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)
DOCKER_COMPOSE := ./scripts/docker-compose.sh
export OPAMROOT OPAMSWITCH PORT

.PHONY: docker-check docker-build docker-shell docker-site docker-serve docker-up

docker-check:
	@$(DOCKER_COMPOSE) version

docker-build: docker-check
	$(DOCKER_COMPOSE) build

docker-shell:
	HOST_UID=$(HOST_UID) HOST_GID=$(HOST_GID) $(DOCKER_COMPOSE) run --rm shell

docker-site:
	HOST_UID=$(HOST_UID) HOST_GID=$(HOST_GID) $(DOCKER_COMPOSE) run --rm build

docker-serve:
	HOST_UID=$(HOST_UID) HOST_GID=$(HOST_GID) $(DOCKER_COMPOSE) run --rm --service-ports serve

docker-up: docker-site docker-serve
