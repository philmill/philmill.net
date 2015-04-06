require 'sinatra/asset_pipeline'

#require 'astro/moon'
# Astro::Moon.phase.phase * 100

Dir["#{Nesta::Env.root}/lib/*.rb"].each {|f| require f}
DropboxSingleton.setup

Encoding.default_external = 'utf-8'
Tilt.prefer Tilt::RedcarpetTemplate

module Nesta
  class App
    helpers ::SinatraHelpers

    # Register the AssetPipeline extension, this goes after all customization
    register Sinatra::AssetPipeline

    configure :production do
      # don't worry about nice looking rendered html in production which is faster to process
      set :haml, { :ugly => true }

      # CSS minification
      set :assets_css_compressor, :sass

      # JavaScript minification
      set :assets_js_compressor, :uglifier

    end
  end
end
