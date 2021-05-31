class CustomersController < ApplicationController

  def index
  end

  def add_product_to_wishlist
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      if (current_customer.wishlist_products << product_variant_id)
        @wishlist_items_count = current_customer.wishlist_products.count
        @product_variant_id = product_variant_id
      end
    end
  end

  def remove_product_from_wishlist
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      if current_customer.wishlist_products.delete(product_variant_id)
        @product_variant_id = product_variant_id
        @wishlist_items_count = current_customer.wishlist_products.count
      end
    end
  end

  def add_product_to_cart
    product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      if (current_customer.cart_products << product_variant_id.to_s)
        @cart_items_count = current_customer.cart_products.count
        @product_variant_id = product_variant_id
      end
    end
  end

  def remove_product_from_cart
    @product_variant_id = fetch_variant_id
    if can_add_or_remove_products?
      if current_customer.cart_products.delete(@product_variant_id)
        @cart_items_count = current_customer.cart_products.count
      end
    end
  end

  def wishlist
    wishlist_products_ids = Customer.current.wishlist_products.members.map(&:to_i)
    wishlist_products = wishlist_products_ids.map do |product_variant_id|
      Product.build_product_for_card(product_variant_id)
    end
    wishlist_products ||= {}
    respond_to do |format|
      format.html { render "wishlist", assigns: { products: wishlist_products, for_wishlist: true } }
      format.json { render json: wishlist_products }
    end
  end

  def cart
    cart_products_ids = Customer.current.cart_products.values.map(&:to_i).uniq
    cart_products = cart_products_ids.map do |product_variant_id|
      ProductVariant.find(product_variant_id).build_product_variant_for_cart
    end
    cart_products ||= {}
    respond_to do |format|
      format.html { render "cart", assigns: { products: cart_products, for_cart: true } }
      format.json { render json: cart_products }
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
