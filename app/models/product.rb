class Product < ApplicationRecord
  include Redis::Objects

  # CallBacks
  before_save :assert_valid_brand_and_product_type

  # Redis
  counter :variants_count

  # one-to-one relationship
  belongs_to :product_type
  belongs_to :brand

  # one-to-many relationship
  has_many :product_variants, dependent: :destroy
  # has_many :variants, class_name: "ProductVariant", dependent: :destroy

  def assert_valid_brand_and_product_type
    raise ActiveRecord::RecordInvalid unless product_type.brands.exists?(id: brand.id)
  end
end

