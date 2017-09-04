module MailboxesHelper

  def form_code(token, fields)
    action_url = "#{root_url}m/#{token}"
    inputs = %Q()
    fields = fields.gsub(" ", "").split(",")
    fields.each do |f|
      field = %Q(
        <div class="field">
          <label for="#{f}">#{f}</label>
          <input type="text" name="#{f}">
        </div>
      )
      inputs += field
    end

    form = %Q(
      <form action="#{action_url}" accept-charset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="✓">
        #{inputs}
        <!-- keep this -->
        <div style="width: 1px; height: 1px; overflow: hidden; display: none;">
          Please leave following field blank:
          <textarea name="comment"></textarea>
        </div>
        <!-- keep this -->

        <div class="actions">
          <input type="submit" value="Send">
        </div>
      </form>
    )

    form.strip.gsub(" ", "").gsub("\n", "")
    markdown(form.to_s)
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    extensions = {

    })
    raw(markdown.render(text))
  end
end
