module SinatraHelpers
  def dropbox_img(path, id_class='')
    capture_haml do
      haml_tag('img'+id_class, src: DropboxSingleton.media(path))
    end
  end

  def dropbox_img_url(path)
    DropboxSingleton.media(path)
  end

  def root_index?
    request.path == '/'
  end

  # helpers from nestacms.com
  def list_articles(articles)
    haml_tag :ul do
      articles.each do |article|
        haml_tag :li do
          haml_tag :a, article.heading, :href => url(article.abspath)
        end
      end
    end
  end

  def article_years
    articles = Page.find_articles
    last, first = articles[0].date.year, articles[-1].date.year
    (first..last).to_a.reverse
  end

  def archive_by_year
    article_years.each do |year|
      haml_tag :li do
        haml_tag :a, :id => "#{year}"
        haml_tag :h2, year
        haml_tag :ol do
          list_articles(Page.find_articles.select { |a| a.date.year == year })
        end
      end
    end
  end
end