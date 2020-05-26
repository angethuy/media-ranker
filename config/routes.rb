Rails.application.routes.draw do

  root to: "pages#index"
  get '/login', to: 'users#login_form', as: "login"
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: "logout"

  resources :ice_creams do
    post 'vote', on: :member
  end

  resources :users, except: [:edit, :new, :update, :destroy]
  
end
