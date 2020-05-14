class User < ApplicationRecord
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


end
