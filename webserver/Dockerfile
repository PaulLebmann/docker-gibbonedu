from httpd:alpine
RUN mkdir -p /var/www/html && chown www-data:www-data /var/www/html

COPY ./httpd_gibbon.conf /usr/local/apache2/conf/httpd.conf
#COPY ./httpd.conf /httpd_conf_mod
