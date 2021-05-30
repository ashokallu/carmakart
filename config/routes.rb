Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index] do
    collection do
      post 'add_product_to_wishlist'
    end
    member do
      post 'remove_product_from_wishlist'
      post 'add_product_to_cart'
      post 'remove_product_from_cart'
    end
  end

  resources :products, only: [:index, :show] do
    resources :product_variants do
    end
  end
end
