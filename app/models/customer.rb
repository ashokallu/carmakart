class Customer < ApplicationRecord

  CURRENT_CUSTOMER_KEY = 'current_customer'

  include Redis::Objects

  # set data type in Redis is a Set data type, it cannot have duplicates.
  # Products in wishlist are unique
  # stores product variant record primary keys as strings
  set :wishlist_products # wishlist

  # list data type in Redis is an array type, it can have duplicates
  # User can have multiple products of same variant in the cart
  # stores product variant record primary keys as strings
  list :cart_products # cart

  class << self
    def current
      if Redis.current.exists?(CURRENT_CUSTOMER_KEY)
        customer_id = Redis.current.get(CURRENT_CUSTOMER_KEY).to_i
        Customer.find_by(id: customer_id) if customer_id.nonzero?
      end
    end

    def set_current_customer(id)
       Redis::Value.new(CURRENT_CUSTOMER_KEY).set(id) && Redis.current.exists?(CURRENT_CUSTOMER_KEY)
    end
  end
end
