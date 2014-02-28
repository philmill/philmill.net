require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

# tell rvm which ruby to run
set :rvm_ruby_string, 'ruby-2.1.1@philmill'
set :rvm_type, :user

set :stages, %w(staging production)
set :default_stage, 'production'

# will be used to set the location of files to be served
set :application, 'philmill'

# This is the user capistrano will use for SSH, and thus, who will own the files it deploys
set :user, 'philmill'
set :group, 'philmill'

# set git as repo type and use cache to speed up deployments
set :scm, :git
set :deploy_via, :remote_cache
set :repository,  'git@github.com:philmill/philmill.net.git'
set :branch, 'master'

set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :copy_exclude, %w(.git/ assets/ themes/philmill/src)

set :keep_releases, 3

namespace :deploy do

  task :start, :roles => [:app, :web] do
    run "service unicorn-pm start"
  end

  task :stop, :roles => [:app, :web] do
    run "service unicorn-pm stop"
  end

  task :restart, :roles => [:app, :web] do
    run "service unicorn-pm restart"
  end

  task :cold do
    deploy.update
  end

  task :link, roles: :app do
    run "ln -nfs #{shared_path}/config/dropbox.yml #{release_path}/config/dropbox.yml"
  end
end

before 'deploy:assets:precompile', 'deploy:link'
after 'deploy:restart', 'deploy:cleanup'
