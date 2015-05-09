# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server 'philmill.net', user: 'philmill', roles: %w{app web}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

set :deploy_to, "/home/philmill/sites/net/#{fetch(:application)}"
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

# create binstubs to wrap unicorn
set :bundle_flags, "--binstubs --deployment --quiet"

# tasks for hooks
# TODO: doesn't seem to like restart, stop/start works fine???
namespace :deploy do
	desc 'Restart Unicorn Worker'
	task :restart do
		on roles(:all) do
			execute :service, "unicorn-pm restart"
		end
	end
end
