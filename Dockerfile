FROM wordpress:php7.1-fpm-alpine
RUN apk add --no-cache ssmtp && rm -rf /tmp/* /var/cache/apk/*
RUN sed -i '$d' /usr/local/bin/docker-entrypoint.sh  && \
    echo 'if [ -n "$SSMTP_MAILHUB" ]; then sed -i "s/^mailhub=.*$/mailhub=$SSMTP_MAILHUB/g" /etc/ssmtp/ssmtp.conf; fi' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'if [ -n "$SSMTP_DOMAIN" ]; then sed -i "s/^#rewriteDomain=.*$/rewriteDomain=$SSMTP_DOMAIN/g" /etc/ssmtp/ssmtp.conf; fi' >> /usr/local/bin/docker-entrypoint.sh && \
    echo 'exec "$@"' >> /usr/local/bin/docker-entrypoint.sh
