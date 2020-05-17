class ProductSnap < ApplicationRecord
  has_one :product_create_event
  has_one :product_delete_event
  has_one :product_restore_event

  class << self
    def create_snap(product)
      self.create(product_id: product.id,
                  code: product.code,
                  name: product.name,
                  unit: product.unit,
                  active: product.active,
                  description: product.description,
                  supplier_id: product.supplier.id,
                  supplier_name: product.supplier.name,
                  price_in: product.price_in,
                  price_out: product.price_out)
    end
  end

  def supplier
    Supplier.find(self.supplier_id)
  end
end
