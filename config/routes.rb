Rails.application.routes.draw do
  root 'pages#home'
  get 'test', to:'pages#test'

  devise_for :clients, path: '/devise'
  devise_for :staffs, path: '/devise'

  namespace :clients do
    root 'application#index'
    mount_devise_token_auth_for 'Client', at: 'auth'
  end

  namespace :staffs do
    root 'application#index'
    mount_devise_token_auth_for 'Staff', at: 'auth'
  end
end
