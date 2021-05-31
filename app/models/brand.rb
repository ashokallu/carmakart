# == Schema Information
#
# Table name: brands
#
#  id   :bigint           not null, primary key
#  name :string(64)       not null
#
class Brand < ApplicationRecord
  # many-to-many relationship
  # Shirt is a product_types which can belong to many brands
  # Many brands have Shirt as product_types.
  has_and_belongs_to_many :product_types

  # one-to-many relationship.
  has_many :products, dependent: :destroy
end
