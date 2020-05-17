class ProductionEvent < ApplicationRecord
  belongs_to :head_event

  has_many :arrival_events
  has_many :realization_events
  has_many :write_off_events
  has_many :refund_events
end
