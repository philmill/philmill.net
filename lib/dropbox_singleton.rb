require 'dropbox_sdk'

module DropboxSingleton
	extend self

	attr_accessor :client

	def setup
		mime_types = %w{audio video image}
		dropbox_conf_path ||= File.expand_path('config/dropbox.yml', Nesta::Env.root)
		dropbox_conf ||= YAML::load(ERB.new(IO.read(dropbox_conf_path)).result)
		@root_path ||= dropbox_conf['root_path']
		@client ||= DropboxClient.new(dropbox_conf['access_token'])

		mime_types.each do |type|
			define_method "#{type}_urls_for" do |path|
				urls_for(type, path)
			end
		end
		nil
	end

	def media(path)
		@client.media("#{@root_path}/#{path}")['url']
	end


	private

	def urls_for(type, path)
		@client.metadata("#{@root_path}/#{path}")['contents'].map do |item|
			next unless item['mime_type'].split('/').first == type
			@client.media(item['path'])['url']
		end
	end
end
