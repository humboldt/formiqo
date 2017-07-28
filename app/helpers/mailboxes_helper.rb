module MailboxesHelper

  def form_code(token)
    action_url = "#{root_url}m/#{token}"
    form = '
        <form action="%{url}" accept-charset="UTF-8" method="post">
          <input name="utf8" type="hidden" value="✓">
          <input name="redirect_success" type="hidden" value="http://google.com">
          <input name="redirect_fail" type="hidden" value="http://google.com">

          <div class="field">
            <label for="email">Email</label>
            <input type="text" name="email">
          </div>

          <div class="field">
            <label for="subject">Subject</label>
            <input type="text" name="subject">
          </div>

          <div class="field">
            <label for="body">Body</label>
            <textarea name="body"></textarea>
          </div>

          <div style="width: 1px; height: 1px; overflow: hidden; display: none;">
            Please leave following field blank:
            <textarea name="comment"></textarea>
          </div>

          <div class="actions">
            <input type="submit" value="Send">
          </div>
        </form>
      '

    form = form % {url: action_url}
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
