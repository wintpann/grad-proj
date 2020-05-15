class Supplier < ApplicationRecord
  validates :name, length: {minimum: 4}
  validates :phone, length: {minimum: 4}
  validates :address, length: {minimum: 4}

  class << self
    def active
      self.all.where(active: true)
    end
    def inactive
      self.all.where(active: false)
    end
  end

end
