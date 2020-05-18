class ProductRestoreEvent < ApplicationRecord
  belongs_to :product_change_event
  belongs_to :product_snap

  def editor
    User.find(self.editor_id)
  end
end
