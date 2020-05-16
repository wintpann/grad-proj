class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :before_saving

  def before_saving
    self.identifier.strip!
    self.identifier.downcase!
    self.name.strip!
    self.lastname.strip!
  end

  has_secure_password

  validates :identifier, uniqueness: {case_sensitive: false}, length: {minimum: 4}
  validates :password, length: {minimum: 6}, allow_blank: true
  validates :name, length: {minimum: 4}
  validates :lastname, length: {minimum: 4}

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      BCrypt::Password.create(string, cost: BCrypt::Engine.cost)
    end

    def active
      self.all.where(active: true)
    end

    def inactive
      self.all.where(active: false)
    end
  end

  def remember
    self.remember_token=User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest)==remember_token
  end

end
