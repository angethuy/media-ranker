Rails.application.routes.draw do

  root to: "pages#index"
  get 'pages/index'

  resources :ice_creams
  resources :users, except: [:edit, :update, :destroy]
  resources :votes, only: [:create]
  
end
