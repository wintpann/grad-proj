class UserDeleteEvent < ApplicationRecord
  belongs_to :user_change_event
  belongs_to :user_snap
end
