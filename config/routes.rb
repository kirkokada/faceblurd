Rails.application.routes.draw do
  root 'images#new'
  
  resources :images

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'

  get 'auth/imgur/callback', to: 'images#auth_callback'
end
