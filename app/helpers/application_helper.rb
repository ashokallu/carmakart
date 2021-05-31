module ApplicationHelper
  def product_info_for_left_sidebar
    ProductType.pluck(:name)
  end

  def brand_info_for_left_sidebar
    Brand.pluck(:name)
  end

  def product_types_from_brand(brand_id)
    Brand.find(brand_id).product_types.pluck(:name)
  end
end
