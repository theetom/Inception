FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server mariadb-client galera-4 -y

COPY script/setup.sh /setup.sh
RUN chmod +x /setup.sh
CMD ["/setup.sh"]
