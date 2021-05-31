class ProductsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "index", assigns: { products: Product.primary_product_listings } }
      format.json { render json: Product.primary_product_listings }
    end
  end

  def show
    product_id = params[:id]
    product_variant_id = params[:variant_id]
    product_description_hash = ProductVariant.find(product_variant_id).build_product_variant unless product_id.nil?
    render "show", assigns: {product_description_hash: product_description_hash}
  end
end
