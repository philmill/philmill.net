require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'astro/moon'
# Astro::Moon.phase.phase * 100

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

require "#{Nesta::App.root}/lib/dropbox_helpers"
DropboxHelpers.setup

run Nesta::App
