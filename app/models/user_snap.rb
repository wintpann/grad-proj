class UserSnap < ApplicationRecord
  has_one :user_create_event
  has_one :user_delete_event
  has_one :user_restore_event

  class << self
    def create_snap(user)
      self.create(user_id: user.id,
                  identifier: user.identifier,
                  name: user.name,
                  lastname: user.lastname,
                  role: user.role,
                  active: user.active)
    end
  end

  def now
    User.find(self.user_id)
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
