class ProductEditEvent < ApplicationRecord
  belongs_to :product_change_event

  def editor
    User.find(self.editor_id)
  end

  def snap_from
    ProductSnap.find(self.from_snap_id)
  end

  def snap_to
    ProductSnap.find(self.to_snap_id)
  end

end
