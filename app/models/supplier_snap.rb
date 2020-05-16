class SupplierSnap < ApplicationRecord
  has_one :supplier_create_event
  has_one :supplier_delete_event
  has_one :supplier_restore_event
end
