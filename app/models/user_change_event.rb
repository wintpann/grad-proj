class UserChangeEvent < ApplicationRecord
  belongs_to :head_event

  has_one :user_create_event
  has_one :user_edit_event
  has_one :user_delete_event
  has_one :user_restore_event
end
