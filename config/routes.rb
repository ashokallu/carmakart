Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
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

  match 'validate_rendering', to: 'products#validate_rendering', via: [:get, :post]

  resources :products, only: [:index, :show] do
    get 'validate_rendering', on: :collection
    resources :product_variants do
    end
  end

  mount Carmakart::API::Base => '/'
end
