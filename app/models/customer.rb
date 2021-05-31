class Customer < ApplicationRecord
  include Redis::Objects

  CURRENT_CUSTOMER_KEY = 'current_customer'

  # Redis attributes
  #
  # The set data type in Redis is like a Set data type in Ruby.
  # Sets are unordered and do not store duplicates.
  # Products in a customer wishlist are unique.
  # Redis stores product variant record primary keys as strings
  set :wishlist_products # wishlist
  #
  # The list data type in Redis is an array type, it can have duplicates
  # User can have multiple products of same variant in the cart
  # stores product variant record primary keys as strings
  list :cart_products # cart

  class << self
    # Used redis as a session store that stores a customer id.
    def current
      if Redis.current.exists?(CURRENT_CUSTOMER_KEY)
        customer_id = Redis.current.get(CURRENT_CUSTOMER_KEY).to_i
        Customer.find_by(id: customer_id) if customer_id.nonzero?
      end
    end

    # To change the session to set another customer to be the current customer.
    def set_current_customer(id)
       Redis::Value.new(CURRENT_CUSTOMER_KEY).set(id) && Redis.current.exists?(CURRENT_CUSTOMER_KEY)
    end
  end
end
