Rails.application.routes.draw do
  resources :images

  root to: 'images#new', as: '/'

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'
end
