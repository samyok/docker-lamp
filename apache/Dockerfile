ARG APACHE_VERSION=""
FROM httpd:${APACHE_VERSION:+${APACHE_VERSION}-}alpine

RUN apk update; \
    apk upgrade;

# Copy apache vhost file to proxy php requests to php-fpm container
COPY demo.apache.conf /usr/local/apache2/conf/demo.apache.conf
RUN echo "Include /usr/local/apache2/conf/demo.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf
RUN mkdir -p /var/www/html/ && chown -Rv www-data:www-data /var/www/html/


# install supervisord
RUN apk add supervisor

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisord.conf

# install + configure cloudflared
#RUN apk add tar wget libc6-compat
#RUN wget -O- https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz | tar xvz
#RUN mkdir -p /etc/cloudflared/
#COPY ~/.cloudflared/cert.pem /etc/cloudflared/
#COPY config.yaml /etc/cloudflared/

CMD ["/usr/bin/supervisord"]
