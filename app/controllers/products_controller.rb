class ProductsController < ApplicationController
  wrap_parameters :products

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

  def validate_rendering
    binding.pry
  end

  def working
    # You need to explicitly pass a :locals hash to pass locals to view templates and layout corresponding to the view template.
    # render locals: {foo: 100, bar: 200}
    # render action: 'validate_rendering', locals: {foo: 100, bar: 200}
    # render 'validate_rendering', locals: {foo: 100, bar: 200}
  end

  def not_working
    # render :validate_rendering, foo: 100, bar: 200
    # render 'validate_rendering', {foo: 100, bar: 200}
    # render action: 'validate_rendering', foo: 100, bar: 200
    # render action: 'validate_rendering', { foo: 100, bar: 200 } # SyntaxError
  end
end
