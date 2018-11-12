#!/bin/bash
#apt-get update
#apt-get -y install curl subversion libmysqlclient-dev libmagickcore-dev libmagickwand-dev imagemagick g++ zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libgmp-dev libreadline6-dev libssl-dev
adduser --home /opt/redmine --shell /bin/bash --gecos 'Redmine application' redmine
passwd -d redmine
usermod -aG sudo redmine
#curl -sSL https://rvm.io/mpapis.asc | gpg --import -
#curl -sSL https://get.rvm.io | bash -s stable --ruby
#mkdir redmine && cd redmine
#source /usr/local/rvm/scripts/rvm
#rvm --default use ruby
svn co http://svn.redmine.org/redmine/branches/3.4-stable redmine
mkdir -p ./redmine/tmp/pids ./redmine/public/plugin_assets
cp ./redmine/config/configuration.yml.example ./redmine/config/configuration.yml
cp ./redmine/config/database.yml.example ./redmine/config/database.yml
sed -i 's/root/redmine/g' ./redmine/config/database.yml
sed -i 's/""/"redmine"/g' ./redmine/config/database.yml
cd redmine
echo "gem 'puma'" >> Gemfile.local
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc 
apt-get update && apt-get install tzdata -y