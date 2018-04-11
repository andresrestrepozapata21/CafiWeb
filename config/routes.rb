Rails.application.routes.draw do
  devise_for :users
  root to: "purchases#index"
  resources :products
  resources :purchases
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
