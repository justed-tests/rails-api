Rails.application.routes.draw do
  # yep, it works this way
  resources :orders, only: [:index]

  resources :tables do
    resources :orders, only: [:create]
  end
end
