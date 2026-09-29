include srcs/.env
export

COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env

all: up

up:
	@mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

clean: down
	docker system prune -af

fclean: down
	docker system prune -af --volumes
	-rm -rf $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress

re: fclean all

.PHONY: all up down logs clean fclean re
