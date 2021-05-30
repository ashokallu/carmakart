class CustomersController < ApplicationController

  def index
  end

  def add_product_to_wishlist
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      current_customer.wishlist_products << product_variant_id
    end
  end

  def remove_product_from_wishlist
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      current_customer.wishlist_products.delete(product_variant_id)
    end
  end

  def add_product_to_cart
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      current_customer.cart_products << product_variant_id
    end
  end

  def remove_product_from_cart
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      current_customer.cart_products.delete(product_variant_id)
    end
  end

  private
    def fetch_variant_id
      params[:variant_id].present? && params[:variant_id].to_s
    end

    def can_add_or_remove_products?
      current_customer.present? && fetch_variant_id.present?
    end
end
