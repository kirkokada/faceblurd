Rails.application.routes.draw do
  root 'pages#home'

  get '/about', to: 'pages#about'

  get '/contact', to: 'pages#contact'

  get '/image', to: 'pages#image'

end
