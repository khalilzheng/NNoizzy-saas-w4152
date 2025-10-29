Rails.application.routes.draw do
  root 'focus#index'
  resources :sounds, only: [:index]
  get '/home', to: 'home#index'
end
