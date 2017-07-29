module MessagesHelper

  def active_scope_link(scope)

  end

  def is_new(message)
    if message.created_at.between?((DateTime.now - 24.hours), DateTime.now)
      content_tag :span, "received today", class: "tag is-success"
    end
  end
end
