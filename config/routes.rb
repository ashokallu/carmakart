Rails.application.routes.draw do

  resources :readers, only: [:index, :show] do
    resources :books, only: [:index, :show] do
      member do
        post :claim_book
        post :return_book
      end

      # defaults format: :json do
        resources :notes, shallow: true do
          collection do
            get :favorited_notes
          end

          member do
            post :mark_as_favorite
          end
        end
      # end
    end
  end
end
