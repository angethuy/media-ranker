Rails.application.routes.draw do

  root to: "pages#index"
  get 'login', to: 'pages#login'

  resources :ice_creams do
    post 'vote', on: :member
  end

  resources :users, except: [:edit, :new, :update, :destroy]
  resources :votes, only: [:create]
  
end
