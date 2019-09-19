Rails.application.routes.draw do
  root 'pages#home'

  devise_for :clients, module: 'clients'
  devise_for :staffs,  module: 'staffs'

  namespace :clients do
    root 'application#index'
    mount_devise_token_auth_for 'Client', at: 'auth'
  end

  namespace :staffs do
    root 'application#index'
    mount_devise_token_auth_for 'Staff', at: 'auth'
  end
end
