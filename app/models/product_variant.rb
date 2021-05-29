class ProductVariant < ApplicationRecord
  include Redis::Objects

  # Redis
  counter :quantity

  # one-to-one relationship
  belongs_to :product
  belongs_to :product_type
  has_one :brand, through: :product

  before_save :assert_valid_product_attributes

  after_create_commit { |variant| variant.product.variants_count.increment }
  after_destroy_commit { |variant| variant.product.variants_count.decrement }

  class << self
    # This implementation can be changed when needed.
    def generate_random_sku_id
      Random.alphanumeric(16).upcase.split(/\d+/).join("-").delete_prefix("-")
    end
  end

  private
    def assert_valid_product_attributes
      product_specific_attributes.assert_valid_keys(product_type.product_attributes)
    end
end
