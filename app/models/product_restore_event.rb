class ProductRestoreEvent < ApplicationRecord
  belongs_to :product_change_event
  belongs_to :product_snap
end
