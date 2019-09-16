Rails.application.routes.draw do
  root 'pages#home'

  devise_for :clients, class_name: 'Client', module: 'clients'
  devise_for :staffs,  class_name: 'Staff::Staff',   module: 'staffs'

  namespace :clients do
    root 'app#index'
    mount_devise_token_auth_for 'Client', at: 'auth'
  end

  namespace :staffs do
    root 'app#index'
  end
end
