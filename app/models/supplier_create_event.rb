class SupplierCreateEvent < ApplicationRecord
  belongs_to :supplier_change_event
  belongs_to :supplier_snap

  def editor
    User.find(self.editor_id)
  end
end
