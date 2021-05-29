class ProductType < ApplicationRecord
  # many-to-many relationship
  # A shirt is a product type, it can belongs to many brands
  has_and_belongs_to_many :brands
end
