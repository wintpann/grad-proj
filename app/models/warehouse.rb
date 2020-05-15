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

    def remove_products(products)
      products.each do |product|
        id=product[0].to_i
        amount=product[1].to_i
        warehouse=Warehouse.find_by(product_id: id)
        warehouse.update_attribute(:amount, warehouse.amount-amount)
        warehouse.destroy if warehouse.amount<=0
      end
    end

    def more_than_is?(products)
      products.each do |product|
        id=product[0].to_i
        amount=product[1].to_i
        return true if amount>self.find_by(product_id: id).amount
      end
      return false
    end

    def new_product?(product_id)
      self.all.each { |p| return false if p.product_id==product_id.to_i}
      return true
    end
  end

end
