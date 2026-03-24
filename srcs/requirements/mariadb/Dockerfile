FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server mariadb-client -y

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld && chmod 755 /run/mysqld

COPY tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh



ENTRYPOINT [ "/tmp/setup.sh" ]
# CMD ["/setup.sh"]
