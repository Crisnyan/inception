FROM alpine:3.22

RUN apk update && \
	apk add --no-cache nginx openssl gettext net-tools iproute2
	
ARG DOMAIN_NAME
ENV DOMAIN_NAME=${DOMAIN_NAME}

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 \
	-subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=Inception/CN=${DOMAIN_NAME}" \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt

COPY conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
