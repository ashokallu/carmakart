class ProductsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "index", assigns: { products: Product.primary_product_listings } }
      format.json { render json: Product.primary_product_listings }
    end
  end

  def show
    product_id = params[:id]
    product_description_hash = Product.build_product(product_id) unless product_id.nil?
    render "show", assigns: {product_description_hash: product_description_hash}
  end
end
