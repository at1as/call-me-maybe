class User < ApplicationRecord
  attr_accessor :remember_token

  VALID_EMAIL_ADD = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :email, :with => VALID_EMAIL_ADD, :on => :create
  
  validates :password, presence: true, length: { minimum: 5 }
  validates_confirmation_of :password
    
  has_secure_password


  # Generate a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns hash digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Remember User
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
