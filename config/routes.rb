Rails.application.routes.draw do

  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
  end
  devise_for :admins
  devise_for :users
  
  # get 'inicio', to: 'site/welcome#index'
  
  resources :sales
  resources :products
  resources :clients
  
  #root to: "site/welcome#index"
  root to: "users_backoffice/welcome#index"
  #root to: "users/users#sing_in"
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
