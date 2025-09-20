
up:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	@chmod 755 $(HOME)/data $(HOME)/data/wordpress $(HOME)/data/mariadb 2>/dev/null || true
	@docker compose -f ./srcs/docker-compose.yml up --build
down:
	@docker compose -f ./srcs/docker-compose.yml down

fclean: down
	@docker rmi $$(docker images -q) 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@sudo rm -rf $(HOME)/data || echo "Note: Need sudo password to remove Docker volumes"

re: down fclean up
