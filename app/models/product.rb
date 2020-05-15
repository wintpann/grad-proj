class Product < ApplicationRecord
  validates :code, uniqueness: {case_sensitive: true}
  validates :name, length: {minimum: 4}
  validates :unit, length: {minimum: 2}
  validates :price_in, numericality: true
  validates :price_out, numericality: true

  belongs_to :supplier
end
