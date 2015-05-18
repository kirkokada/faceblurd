Rails.application.routes.draw do
  root 'images#new'
  
  resources :images

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'
end
