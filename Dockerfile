FROM php:5.6.40-apache

RUN curl -L https://github.com/hairyhenderson/gomplate/releases/download/v2.3.0/gomplate_linux-amd64-slim > /usr/local/bin/gomplate && \
  chmod u+x /usr/local/bin/gomplate

RUN apt-get update && \
  apt-get install -y ssmtp libgd-dev && \
  apt-get clean && \
  echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/mail.ini && \
  docker-php-ext-install mysql gd

ENV SSMTP_HOST=postfix \
  SSMTP_PORT=25 \
  SSMTP_FROM_HOSTNAME=example.com \
  SSMTP_USE_TLS=Yes \
  SSMTP_USE_STARLTLS=Yes \
  SSMTP_AUTH_USER=user \
  SSMTP_AUTH_PASSWORD=password \
  SSMTP_AUTH_METHOD=LOGIN

COPY ./ssmtp.conf.tmpl /ssmtp.conf.tmpl

COPY ./docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
