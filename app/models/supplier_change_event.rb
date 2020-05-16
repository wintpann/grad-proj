class SupplierChangeEvent < ApplicationRecord
  belongs_to :head_event

  has_one :supplier_create_event
  has_one :supplier_edit_event
  has_one :supplier_delete_event
  has_one :supplier_restore_event
end
