require 'phonelib'

class Conversation < ApplicationRecord
  default_scope -> { order(start_time: :desc) }

  VALID_EMAIL_ADD = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :guest_email, presence: true
  validates :start_time, presence: true
  validates_format_of :guest_email,  :with => VALID_EMAIL_ADD, :on => :create, :allow_blank => false
  validates :phonenumber, phone: { possible: true, allow_blank: true }
end
