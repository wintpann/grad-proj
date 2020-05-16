class UserEditEvent < ApplicationRecord
  belongs_to :user_change_event

  def editor
    User.find(self.editor_id)
  end

  def snap_from
    UserSnap.find(self.from_snap_id)
  end

  def snap_to
    UserSnap.find(self.to_snap_id)
  end
end
