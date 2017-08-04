module ApplicationHelper
  def url_link(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def subscription_expiration(user)
    d = (Time.zone.now.to_i - user.subscription.end_date.to_i) / 84600

    expires_in = distance_of_time_in_words(Time.zone.now, user.subscription.end_date)
    text = "Your subscription expires in ~ #{expires_in}."
    if d.abs <= 5
      content_tag(:article, class: 'message is-danger menu-alert') do
        content_tag(:div, class: 'message-body') do
          concat text
          concat " "
          concat link_to "prolong it here", subscriptions_path
        end
      end
    end
  end
end
