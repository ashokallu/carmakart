class ApplicationController < ActionController::Base
  skip_forgery_protection

  helper_method :current_customer

  def current_customer
    Customer.current
  end
end
