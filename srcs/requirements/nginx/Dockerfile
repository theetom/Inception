FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl gettext

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=ES/ST=Malaga/L=Malaga/O=42/OU=42/CN=toferrei.42.fr"

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf.template

EXPOSE 443

COPY tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
ENTRYPOINT [ "/usr/local/bin/setup.sh" ]