Rails.application.routes.draw do

	devise_for :users
	resources :users
    resources :microposts

	root 'pages#index'
	

end
