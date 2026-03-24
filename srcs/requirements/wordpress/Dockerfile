FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y tar wget php php-fpm php-mysql mariadb-client
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz

RUN mv wordpress /var/www/html/wordpress

COPY tools/setup.sh /wordpress.sh
RUN chmod +x /wordpress.sh
# CMD ["/wordpress.sh"]