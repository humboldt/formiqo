class Message < ApplicationRecord
  store_accessor :message_fields
  attr_accessor :comment

  belongs_to :mailbox
  validates_length_of :comment, :in => 0..1

  default_scope { order(created_at: :desc) }
  scope :today, -> { where(created_at: ((DateTime.now - 24.hours)..DateTime.now)) }


  def self.search(q)
    if !q.blank?
      k, v = key_val_of(q)
      st = "message_fields ->> '%{key}' = ?" % {key: k}
      where(st, v)
    else
      all
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      all.each do |msg|
        csv << [msg.mailbox.name] + msg.attributes["message_fields"].values_at(*msg.mailbox.allowed_fields.gsub(" ", "").split(","))
      end
    end
  end

  private
    # "email: ww@ww.com" => ["email", "ww@ww.com"]
    def self.key_val_of(st)
      pattern = /([a-z]\w+\:)/
      value = st.sub(pattern, "").sub(":", "").strip
      key = st.remove(value).sub(":", "").strip

      [key, value]
    end

end
