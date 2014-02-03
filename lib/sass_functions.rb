module Sass::Script::Functions
  def dropbox_url(path)
    assert_type path, :String
    Sass::Script::String.new("url(" + DropboxHelpers.media(path.value) + ")")
  end
  declare :dropbox_url, :args => [:path]
end