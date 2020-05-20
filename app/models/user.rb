class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :before_saving

  def before_saving
    self.identifier.strip!
    self.identifier.downcase!
    self.name.strip!
    self.lastname.strip!
    self.last_seen=Time.now
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

  def can?(action)
    self.role.split(',').each do |a|
      return true if a==action
    end
    return false
  end

  def add_right(right)
    self.update_attribute(:role, self.role+",#{right}")
  end

  def remove_right(right)
    temp=[]
    self.role.split(',').each do |a|
      temp << a if a!=right
    end
    self.update_attribute(:role, temp.join(','))
  end

  def update_rights(params)
    new_rights=[]
    params.each do |right|
      new_rights << right[0] if right[1]=='1'
    end
    self.update_attribute(:role, new_rights.join(','))
  end

  def rights
    temp=[]
    self.role.split(',').each do |r|
      case r
      when 'set_rights'
        temp << r.humanize
      when 'invites'
        temp << 'Generate invites'
      when 'change_self'
        temp << r.humanize
      when 'change_users'
        temp << r.humanize
      when 'active_users'
        temp << 'Delete/Restore users'
      when 'all_users'
        temp << r.humanize
      when 'change_suppliers'
        temp << r.humanize
      when 'active_suppliers'
        temp << 'Delete/Restore suppliers'
      when 'change_products'
        temp << r.humanize
      when 'active_products'
        temp << 'Delete/Restore products'
      when 'warehouse'
        temp << r.humanize
      when 'arrival'
        temp << r.humanize
      when 'realization'
        temp << r.humanize
      when 'refund'
        temp << r.humanize
      when 'write_off'
        temp << r.humanize
      when 'events'
        temp << r.humanize
      end
    end
    return temp
  end

end
