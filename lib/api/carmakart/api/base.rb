module Carmakart
  module API
    class Base < Grape::API::Instance
      version 'v1', using: :path
      prefix :api

      mount Products
    end
  end
end