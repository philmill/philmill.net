require 'sinatra/base'
require 'sinatra/asset_pipeline/task.rb'
require 'compass'
require 'susy'

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))
require 'nesta/app'
require Nesta::Path.themes(Nesta::Config.theme, 'app.rb')

Sinatra::AssetPipeline::Task.define! Nesta::App