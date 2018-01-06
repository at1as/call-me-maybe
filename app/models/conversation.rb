class Conversation < ApplicationRecord
  default_scope -> { order(start_time: :desc) }

  VALID_EMAIL_ADD = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  VALID_PHONE_NUM = /\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*/i

  validates :guest_email, presence: true
  validates_format_of :guest_email,  :with => VALID_EMAIL_ADD, :on => :create, :allow_blank => false
  #validates_format_of :phonenumber, :with => VALID_EMAIL_ADD, :on => :create, :allow_blank => true
end
