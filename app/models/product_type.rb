class ProductType < ApplicationRecord
  # many-to-many relationship
  # A shirt is a product type, it can belongs to many brands
  has_and_belongs_to_many :brands

  # product_attributes will be same for a product type
  # for a particular product, the changing attributes are variant attributes.
end
