class SupplierEditEvent < ApplicationRecord
  belongs_to :supplier_change_event

  def editor
    User.find(self.editor_id)
  end

  def snap_from
    SupplierSnap.find(self.from_snap_id)
  end

  def snap_to
    SupplierSnap.find(self.to_snap_id)
  end
end
