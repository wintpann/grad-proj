class SupplierCreateEvent < ApplicationRecord
  belongs_to :supplier_change_event
  belongs_to :supplier_snap
end
