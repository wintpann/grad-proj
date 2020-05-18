class UserDeleteEvent < ApplicationRecord
  belongs_to :user_change_event
  belongs_to :user_snap

  def editor
    User.find(self.editor_id)
  end
end
