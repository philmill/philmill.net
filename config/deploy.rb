require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

# tell rvm which ruby to run
set :rvm_ruby_string, 'ruby-2.0.0-p247'
set :rvm_type, :user

# set bundle executible to the global gemset
set :bundle_cmd, '/home/philmill/.rvm/gems/ruby-2.0.0-p0@global/bin/bundle'
# set bundle deployment location to a common directory for sharing gems between projects
# this also allows us to use thin as an OS service (rvm wrapper points here) as well as start and stop individual projects as needed
set :bundle_dir, '/home/philmill/.shared_bundle'

set :stages, %w(staging production)
set :default_stage, 'production'

# will be used to set the location of files to be served
set :application, 'philmill'

# This is the user capistrano will use for SSH, and thus, who will own the files it deploys
set :user, 'philmill'
set :group, 'philmill'

# no assets here
set :normalize_asset_timestamps, false

# set git as repo type and use cache to speed up deployments
set :scm, :git
set :deploy_via, :remote_cache
set :repository,  'git@github.com:philmill/philmill.net.git'
set :branch, 'master'

set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :copy_exclude, %w(.git/ themes/philmill/src)

set :keep_releases, 3

namespace :deploy do

  task :start, :roles => [:app, :web] do
    run "cd #{deploy_to}/current && nohup bundle exec thin -C /etc/thin/philmill.yml start"
  end

  task :stop, :roles => [:app, :web] do
    run "cd #{deploy_to}/current && nohup bundle exec thin -C /etc/thin/philmill.yml stop"
  end

  task :restart, :roles => [:app, :web] do
    deploy.stop
    deploy.start
  end

  task :cold do
    deploy.update
  end

  task :link, roles: :app do
    run "ln -nfs #{shared_path}/config/as3.yml #{release_path}/config/as3.yml"
  end
end

after 'deploy:update_code', 'deploy:link'
after 'deploy:restart', 'deploy:cleanup'
