class ArrivalEvent < ApplicationRecord
  belongs_to :production_event
  belongs_to :product
  belongs_to :product_snap
end
