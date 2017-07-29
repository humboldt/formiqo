class Message < ApplicationRecord
  attr_accessor :comment, :redirect_success, :redirect_fail

  belongs_to :mailbox

  validates :email, :body, presence: true
  validates_length_of :comment, :in => 0..1

  default_scope { order(created_at: :desc) }
  scope :today, -> { where(created_at: ((DateTime.now - 24.hours)..DateTime.now)) }

  def self.search(q)
    if q
      where("body LIKE :q OR subject LIKE :q OR email LIKE :q", q: "%#{q}%")
    else
      all
    end
  end

  def self.to_csv
    attrs = %w{email subject body created_at}
    CSV.generate do |csv|
      all.each do |msg|
        csv << [msg.mailbox.name] + msg.attributes.values_at(*attrs)
      end
    end
  end
end
