FROM ubuntu:16.04

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql \
    DB_USER=redmine \
    DB_PASS=redmine \
    DB_NAME=redmine

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y curl subversion libmysqlclient-dev \
 libmagickcore-dev libmagickwand-dev imagemagick g++ zlib1g-dev libyaml-dev \ 
 libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake \ 
 libtool bison pkg-config libffi-dev libgmp-dev libreadline6-dev libssl-dev

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
 && curl -sSL https://get.rvm.io | bash -s stable --ruby
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh
RUN mkdir redmine
COPY /scripts/install_redmine.sh /redmine/install_redmine.sh
RUN chmod 755 /redmine/install_redmine.sh
RUN /redmine/install_redmine.sh
COPY /scripts/puma.rb /redmine/config/puma.rb
COPY /scripts/run_puma.sh /redmine/run_puma.sh
RUN chmod 755 /redmine/run_puma.sh

EXPOSE 3000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/bin/mysqld_safe"]