FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y nginx

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

EXPOSE 8080

ADD nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /etc/nginx
CMD ["nginx"]