FROM nginx:1.20.0

RUN mkdir -p /var/www/rails/Moviest/log

RUN rm -f /etc/nginx/conf.d/*

ADD Moviest.conf /etc/nginx/conf.d/Moviest.conf

ADD mime.types /etc/nginx

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/conf.d/Moviest.conf
