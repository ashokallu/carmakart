class Customer < ApplicationRecord
  include Redis::Objects
  set :wishlist_products
  set :cart_products
  # wishlist
  # cart
end
