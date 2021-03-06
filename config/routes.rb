Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "products#index"

  resources :customers, only: [:index] do
    collection do
      post 'add_product_to_wishlist'
      post 'remove_product_from_wishlist'
      post 'add_product_to_cart'
      post 'remove_product_from_cart'
      get 'wishlist'
      get 'cart'
    end
  end

  resources :products, only: [:index, :show] do
    resources :product_variants do
    end
  end
end
