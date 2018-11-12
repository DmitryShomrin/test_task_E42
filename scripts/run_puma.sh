#!/bin/bash
#cd /redmine/redmine
cd redmine
source /usr/local/rvm/scripts/rvm
rvm --default use ruby
#gem install bundler
#bundle install --without development test postgresql sqlite
rake generate_secret_token
RAILS_ENV=production rake db:migrate
RAILS_ENV=production REDMINE_LANG=en rake redmine:load_default_data
chown -R redmine:redmine files log tmp public/plugin_assets
chmod -R 755 files log tmp public/plugin_assets
#puma config
bundle exec puma --config config/puma.rb
