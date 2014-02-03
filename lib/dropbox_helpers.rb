require 'dropbox_sdk'

module DropboxHelpers
  extend self

  attr_accessor :client

  def setup
    @dropbox_conf_path ||= File.expand_path('config/dropbox.yml', Nesta::App.root)
    @dropbox_conf ||= YAML::load(ERB.new(IO.read(@dropbox_conf_path)).result)
    @root_path ||= @dropbox_conf['root_path']
    @client ||= DropboxClient.new(@dropbox_conf['access_token'])
  end

  def media(path)
    @client.media(@root_path+'/'+path)['url']
  end
end