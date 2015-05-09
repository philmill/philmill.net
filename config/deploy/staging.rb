# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server 'philmill.dev', user: 'philmill', roles: %w{app web}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

set :deploy_to, "/Users/philmill/WebDev/staging/#{fetch(:application)}"
set :branch, 'staging'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/local/bin/rbenv exec"
set :linked_dirs, %w{tmp}

# tasks for hooks
namespace :deploy do
	desc 'Restart Pow'
	task :restart do
		on roles(:all) do
			within release_path do
				#execute :touch, "#{fetch(:deploy_to)}/current/tmp/restart.txt"
				execute :touch, "tmp/restart.txt"
			end
		end
	end
end
