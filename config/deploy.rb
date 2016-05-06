require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/config'

set :term_mode, :system
set :forward_agent, true
set :rvm_path, '/usr/local/rvm/scripts/rvm'

task :environment do

end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/app_config.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/app_config.yml'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/secrets.yml'."]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public/system"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/public/system'."]

  queue! %[mkdir -p "#{deploy_to}/shared/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/pids"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    #queue! "RAILS_ENV=#{rails_env} bundle exec rake db:create"
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    invoke :'seed'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

desc "Seed data to the database"
task :seed => :environment do
  puts "-----> Seeding Database"
  queue "cd #{release_path}/"
  queue "RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  puts "-----> Seeding Completed."
end
