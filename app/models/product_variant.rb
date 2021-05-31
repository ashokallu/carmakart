class ProductVariant < ApplicationRecord
  include Redis::Objects

  # You must only pass single quoted values to 'jsonb_column_key' argument
  # This is an alias for the argument to ::fetch_distinct_values_from_a_jsonb_column
  ALIASES = {
    Size: 'Size',
    Color: 'Color',
  }

  # Redis attributes
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

    # Rails does not yet support querying "jsonb" data types.
    # You must only pass single quoted values to 'jsonb_column_key' argument
    # quoting of table names if for sanitizing the string inputs.
    # query returns an instance of ActiveRecord::Result, and values can be extracted from the query.
    def fetch_distinct_values_from_a_jsonb_column(jsonb_column_name, jsonb_column_key, where_conditions_hash = {}, distinct = true)
      table_name = connection.quote_table_name(self.table_name)
      jsonb_column = connection.quote_column_name(jsonb_column_name)
      where_condition_string = ' WHERE ' unless where_conditions_hash.empty?
      where_conditions_hash.each do |k, v|
        where_column = connection.quote_column_name(k)
        value = connection.quote(v)
        where_condition_string += ("#{where_column} = #{value}" + "AND")
      end
      where_condition_string.delete_suffix!("AND") unless where_conditions_hash.empty?
      jsonb_column_key = ALIASES[jsonb_column_key.to_sym]
      sql_string = "SELECT #{distinct ? "DISTINCT" : ""} #{jsonb_column} -> '#{jsonb_column_key}' FROM #{table_name}" + where_condition_string.to_s
      sql_query = Arel.sql(sql_string)
      result = connection.exec_query(sql_query)
      result.rows.flatten.compact.map do |str|
        new_str = str.delete_prefix('"') if str.start_with?('"')
        new_str = new_str.delete_suffix('"') if new_str && new_str.end_with?('"')
        new_str || str # A string can be unquoted, in such cases, new_str is nil.
      end
    end
  end

  def fetch_variant_attributes(where_conditions_hash = {})
    jsonb_column_name = "variant_specific_attributes"
    attributes_hash = {}
    where_conditions_hash.merge!(product_id: self.product_id)
    ALIASES.values.each_with_object(attributes_hash) do |jsonb_column_key, obj|
      obj[jsonb_column_key.downcase.to_sym] = self.class.fetch_distinct_values_from_a_jsonb_column(jsonb_column_name, jsonb_column_key, where_conditions_hash)
    end
  end

  def build_product_variant(to_json = false)
    begin
      product_variant = self
      product_details_hash = product.instance_eval do
        {
          product_id: id,
          product_name: product_name,
          product_description: product_description,
          product_brand_id: brand.id,
          product_brand_name: brand.name,
          product_type: product_type.name,
          variant_id: product_variant.id,
          variant_name: product_variant.name,
          variant_price: product_variant.variant_price,
          sku_id: product_variant.sku_id,
        }
      end.merge(variant_specific_attributes).merge(product_specific_attributes).symbolize_keys.transform_keys! {|k| k.downcase}
      to_json ? product_details_hash.to_json : product_details_hash
    rescue
      {}
    end
  end

  def build_product_variant_for_cart(to_json = false)
    begin
      valid_keys = [:product_name, :product_brand_name, :variant_id, :variant_name, :variant_price, :color, :size, :product_id, :product_type]
      product_details_hash = build_product_variant(to_json).keep_if do |k, v|
        valid_keys.include?(k)
      end
      to_json ? product_details_hash.to_json : product_details_hash
    rescue
      {}
    end
  end

  private
    def assert_valid_product_attributes
      product_specific_attributes.assert_valid_keys(product_type.product_attributes)
    end
end
