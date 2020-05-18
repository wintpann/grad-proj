class SupplierSnap < ApplicationRecord
  has_one :supplier_create_event
  has_one :supplier_delete_event
  has_one :supplier_restore_event

  class << self
    def create_snap(supplier)
      self.create(supplier_id: supplier.id,
                  name: supplier.name,
                  phone: supplier.phone,
                  address: supplier.address)
    end
  end
end
