class UserSnap < ApplicationRecord
  has_one :user_create_event
  has_one :user_delete_event
  has_one :user_restore_event
end
