set :domain, 'local.philmill.net'
server domain, :app, :web, :primary => true

set :deploy_to, "/home/philmill/webDev/staging/#{application.downcase}_net"
