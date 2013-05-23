set :domain, 'philmill.net'
server domain, :app, :web, :primary => true

set :deploy_to, "/home/philmill/sites/net/#{application.downcase}"
