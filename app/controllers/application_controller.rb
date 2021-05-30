class ApplicationController < ActionController::Base
  helper_method :current_customer

  def current_customer
    Customer.current
  end
end
