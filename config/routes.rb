Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :microposts

  root 'pages#index'
  resources :users do
    member do
     get :following, :followers
   end
 end

 resources :relationships,	only: [:create, :destroy]
end
