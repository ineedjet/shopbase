Rails.application.routes.draw do
  root 'pages#home'
  get 'test', to:'pages#test'

  devise_for :clients, path: '/clients/devise'
  devise_for :staffs, path: '/staffs/devise'

  namespace :clients do
    get '/', to: 'application#index'
    mount_devise_token_auth_for 'Client', at: 'auth'
  end

  namespace :staffs do
    get '/', to: 'application#index'
    mount_devise_token_auth_for 'Staff', at: 'auth'
  end
end
