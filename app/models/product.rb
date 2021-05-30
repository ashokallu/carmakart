class Product < ApplicationRecord
  include Redis::Objects

  # CallBacks
  before_save :assert_valid_brand_and_product_type

  # Redis
  counter :variants_count
  value :primary_variant_id

  # one-to-one relationship
  belongs_to :product_type
  belongs_to :brand

  # one-to-many relationship
  has_many :product_variants, dependent: :destroy
  # has_many :variants, class_name: "ProductVariant", dependent: :destroy

  class << self
    def build_product(to_json = false, product_variant_id = nil, product_id)
      begin
        product = Product.where(id: product_id).includes(:brand).first
        variant_id = product_variant_id.nil? ? product.primary_variant_id.value : product_variant_id
        product_variant = product.product_variants.where(id: variant_id)
        product_variant = product.primary_variant if product_variant.none?
        product_details_hash = product.instance_eval do
          {
            product_id: id,
            product_name: product_name,
            description: product_description,
            brand_id: brand.id,
            brand: brand.name,
            variant_id: product_variant.id,
            sku_id: product_variant.sku_id,
            variant_name: product_variant.name,
          }.merge(product_variant.variant_specific_attributes).merge(product_variant.product_specific_attributes).symbolize_keys
        end
        to_json ? product_details_hash.to_json : product_details_hash
      rescue
        {}
      end
    end

    def primary_product_listings(to_json = false)
      Rails.cache.fetch [__method__], expires_in: 30.minutes do
        all = ids.map do |id|
          Product.find(id).build_product_for_card
        end
        all.reject { |product| product.empty? }
      end
    end
  end

  def build_product_for_card(product_variant_id = nil, to_json = false)
    begin
      product_variant = if product_variant_id.nil?
        primary_variant
      else
        ProductVariant.find(product_variant_id)
      end
      product = product_variant.product
      brand = product.brand
      product_details_hash = product.instance_eval do
        {
          product_id: id,
          product_brand_id: brand.id,
          product_brand_name: brand.name,
          variant_id: product_variant.id,
          variant_name: product_variant.name,
          variant_price: product_variant.variant_price,
          **available_variants_hash
        }.symbolize_keys
      end
      to_json ? product_details_hash.to_json : product_details_hash
    rescue
      {}
    end
  end

  def available_variants_hash
    product_variant = self.product_variants.limit(1).first
    product_variant.fetch_variant_attributes if product_variant
  end

  # A product has many variants, we can set a primary_variant and always return
  # it in the products listing.
  # If no primary_variant is set, returns the #first.
  def primary_variant
    variant_id = primary_variant_id.value
    if variant_id.nil?
      product_variants.first
    else
      product_variants.find(variant_id)
    end
  end

  def assert_valid_brand_and_product_type
    raise ActiveRecord::RecordInvalid unless product_type.brands.exists?(id: brand.id)
  end
end

