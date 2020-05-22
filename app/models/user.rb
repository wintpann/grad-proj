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
  validates :name, length: {minimum: 2}
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
        temp << 'Назначать права'
      when 'invites'
        temp << 'Делать приглашения'
      when 'change_self'
        temp << 'Редактировать себя'
      when 'change_users'
        temp << 'Редактировать пользователей'
      when 'active_users'
        temp << 'Удалять/восстанавливать пользователей'
      when 'all_users'
        temp << 'Смотреть всех пользователей'
      when 'change_suppliers'
        temp << 'Редактировать поставщиков'
      when 'active_suppliers'
        temp << 'Удалять/восстанавливать поставщиков'
      when 'change_products'
        temp << 'Редактировать продукты'
      when 'active_products'
        temp << 'Удалять/восстанавливать продукты'
      when 'warehouse'
        temp << 'Склад'
      when 'arrival'
        temp << 'Поступление товара'
      when 'realization'
        temp << 'Реализация товара'
      when 'refund'
        temp << 'Возврат товара'
      when 'write_off'
        temp << 'Списание товара'
      when 'events'
        temp << 'Все события'
      end
    end
    return temp
  end

end
