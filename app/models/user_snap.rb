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
end
