module Carmakart::API
  class Products < Base
    # do_not_route_head!

    default_format :json
    format :xml

    # content_type :rss, 'application/xml+rss'
    # content_type :json, 'application/json'

    helpers Helpers::Products

    define_singleton_method :content_types do
      super.except(:xml)
    end

    route [:get, :post], ["status", "stats"] do
      # env['api.format'] = :json
      binding.pry
      {foo: 100, bar: 200}
    end

    params do
      requires :id, type: Hash do
        requires :int, coerce: Integer
      end
    end
    route :any, 'product_methods/:product_id/show' do
      binding.pry
    end

    segment :custom do
      get :croute do
        binding.pry
        {foo: 100}
      end
      
      route_param :ids, type: Integer do
        get :croute do
          binding.pry
          {foo: 100}
        end
      end
    end

    # resource ':id' do
    #   params do
    #     requires :id, type: Integer
    #   end
    #   desc 'return list of products'
    #   get do
    #     products = Product.limit(10)
    #     present products
    #   end
    # end
  end
end