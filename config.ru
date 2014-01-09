require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'sass/plugin/rack'
Compass.add_project_configuration('config/compass.config')
Compass.configure_sass_plugin!
require 'zen-grids'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack  # Sass Middleware

use Rack::Coffee, root: 'themes/philmill/public', urls: '/philmill/javascripts', cache_control: [3600, :public]

# Nice looking 404s and other messages
use Rack::ShowStatus
use Rack::ConditionalGet
use Rack::ETag

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'

require "#{Nesta::App.root}/lib/site_bucket"
as3_conf_path = File.expand_path('config/as3.yml', Nesta::App.root)
as3_conf=YAML::load(ERB.new(IO.read(as3_conf_path)).result)
SiteBucket.current_bucket = as3_conf['bucket']
#SiteBucket.establish_connection!(access_key_id: as3_conf['access_key_id'], secret_access_key: as3_conf['secret_access_key'])

run Nesta::App
