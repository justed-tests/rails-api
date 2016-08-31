Rails.application.routes.draw do
  get 'stats', to: 'stats#index'

  resources :orders, only: [:index]

  resources :tables do
    resources :orders, only: [:create] do
      post :add, on: :member
      post :pay, on: :member
    end
  end
end
