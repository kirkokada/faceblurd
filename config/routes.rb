Rails.application.routes.draw do
  get 'images/new'

  post 'images', to: 'images#create' 

  root 'pages#home'

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'
end
