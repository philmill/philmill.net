Encoding.default_external = 'utf-8'
Tilt.prefer Tilt::RedcarpetTemplate

module Nesta
  class App
    use Rack::Static, :urls => ['/philmill'], :root => 'themes/philmill/public'

    # use compass rendering instead of default
    get '/css/:sheet.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass(params[:sheet].to_sym, Compass.sass_engine_options)
    end

    # define helper methods for view templates
    helpers do
      # define wrappers for DropboxHelpers
      def dropbox_img(path, id_class='')
        capture_haml do
          haml_tag('img'+id_class, src: DropboxHelpers.media(path))
        end
      end
    end

    # don't worry about nice looking rendered html in production which is faster to process
    configure :production do
      set :haml, { :ugly => true }
    end
  end
end
