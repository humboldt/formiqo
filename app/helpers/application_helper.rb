module ApplicationHelper
  def url_link(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end
