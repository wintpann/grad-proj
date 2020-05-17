class ProductSnap < ApplicationRecord
  has_one :product_create_event
  has_one :product_delete_event
  has_one :product_restore_event
end
