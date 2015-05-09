# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'philmill'
set :repo_url, 'git@github.com:philmill/philmill.net.git'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :linked_files, fetch(:linked_files, []).push('config/as3.yml', 'config/dropbox.yml')

# Default value for keep_releases is 5
set :keep_releases, 3

set :copy_exclude, %w(.git/ themes/philmill/src)

after 'deploy:published', 'deploy:restart'

namespace :deploy do
	after :restart, :clear_cache do
		on roles(:web), in: :groups, limit: 3, wait: 10 do
			within release_path do
				execute :bundle, :exec, 'rake assets:clean'
			end
		end
	end
end
