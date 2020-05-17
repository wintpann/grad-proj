class RefundEvent < ApplicationRecord
  belongs_to :production_event
  belongs_to :product
  belongs_to :product_snap

  class << self
     def create_refund(options={})
       options[:params].each do |item|
         product_id=item[0].to_i
         amount=item[1].to_f
         product_snap=ProductSnap.create_snap(Product.find(product_id))
         arrival_event=self.create(production_event_id: options[:event].id,
                                   product_id: product_id,
                                   product_snap_id: product_snap.id,
                                   amount: amount,
                                   sum: product_snap.price_in*amount)
         arrival_event.production_event.update_sum(arrival_event.sum)
       end
     end
   end
   
end
