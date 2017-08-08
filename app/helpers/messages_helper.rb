module MessagesHelper

  def active_scope_link(scope)

  end

  def is_new(message)
    if message.created_at.between?((DateTime.now - 24.hours), DateTime.now)
      content_tag :span, "received today", class: "tag is-theme"
    end
  end

  def structured_fields_for(message)
    # h = {}
    # message.message_fields.each do |k, v|
    #   h[k]=v
    # end

    # content_tag :div, message.message_fields
    allowed_fields = message.mailbox.allowed_fields.gsub(" ", "").split(",")
    content_tag :ul, class: "message-fields" do
      allowed_fields.each do |f|
        concat content_tag :li, "#{f}: #{message.message_fields[f]}"
      end
    end
  end
end
