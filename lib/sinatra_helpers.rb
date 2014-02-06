module SinatraHelpers
  def dropbox_img(path, id_class='')
    capture_haml do
      haml_tag('img'+id_class, src: DropboxSingleton.media(path))
    end
  end
end