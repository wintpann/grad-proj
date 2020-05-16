class Product < ApplicationRecord
  validates :code, uniqueness: {case_sensitive: true}
  validates :name, length: {minimum: 4}
  validates :unit, length: {minimum: 2}
  validates :price_in, numericality: true
  validates :price_out, numericality: true

  belongs_to :supplier
  has_one :warehouse

  class << self
    def active
      self.all.where(active: true)
    end
    def inactive
      self.all.where(active: false)
    end
    def params
      temp=[]
      self.all.each {|p| temp << p.id.to_s}
      return temp
    end
    def codes
      temp=[]
      self.all.each {|p| temp << p.code}
      return temp
    end
  end

end
