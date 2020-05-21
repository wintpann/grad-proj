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
