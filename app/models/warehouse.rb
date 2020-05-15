class Warehouse < ApplicationRecord
  belongs_to :product

  class << self
    def add_products(products)
      products.each do |product|
        id=product[0].to_i
        amount=product[1].to_i
        if self.new_product?(id)
          Warehouse.create(product_id: id, amount: amount)
        else
          warehouse=Warehouse.find_by(product_id: id)
          warehouse.update_attribute(:amount, warehouse.amount+amount)
        end
      end
    end

    def new_product?(product_id)
      self.all.each { |p| return false if p.product_id==product_id.to_i}
      return true
    end
  end

end
