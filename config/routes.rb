Rails.application.routes.draw do
  root "brackets#index"
  
  resources :matchups
  resources :entries
  resources :brackets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
