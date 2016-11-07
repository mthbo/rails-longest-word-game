Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'game', to: 'pages#game'
  get 'score', to: 'pages#score'
  get 'login', to: 'logins#login'
  post 'create', to: 'logins#create'
  get 'destroy', to: 'logins#destroy'
end
