class HeadEvent < ApplicationRecord
  has_one :user_change_event
  has_one :supplier_change_event
end
