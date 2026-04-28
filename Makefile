VOLUMES_PATH = /home/${USER}/data

DB_PATH = ${VOLUMES_PATH}/mariadb
WP_PATH = ${VOLUMES_PATH}/wordpress

all:
	mkdir -p ${DB_PATH} ${WP_PATH}
	docker compose -f srcs/docker-compose.yml up --build -d

restart:
	docker compose -f srcs/docker-compose.yml restart

clean: stop
	docker system prune -a --force

fclean: clean
	sudo rm -rf /home/${USER}/data

re: fclean all

buildmariadb:
	docker build srcs/requirements/mariadb -t mariadb

runmariadb: buildmariadb
	mkdir -p ${DB_PATH} ${WP_PATH}
	docker run mariadb


testdb:
	docker exec -it mariadb mysql -u root -p
stop:
	docker compose -f srcs/docker-compose.yml down




.PHONY: all clean fclean stop testdb re buildmariadb runmariadb
