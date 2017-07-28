class Message < ApplicationRecord
  attr_accessor :comment, :redirect_success, :redirect_fail

  belongs_to :mailbox

  validates :email, :body, presence: true
  validates_length_of :comment, :in => 0..1

  default_scope { order(created_at: :desc) }

  def self.to_csv
    attrs = %w{email subject body created_at}
    CSV.generate do |csv|
      all.each do |msg|
        csv << [msg.mailbox.name] + msg.attributes.values_at(*attrs)
      end
    end
  end
end
