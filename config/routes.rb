Rails.application.routes.draw do
  resources :orders, only: [:index]

  resources :tables do
    resources :orders, only: [:create] do
      post :add, on: :member
    end
  end
end
