Rails.application.routes.draw do
  root 'pages#home'

  devise_for :clients, class_name: 'Client::Client', module: 'clients'
  devise_for :staffs,  class_name: 'Staff::Staff',   module: 'staffs'

  namespace :clients do
    get 'app/show'
  end

  namespace :staffs do
    get 'app/show'
  end
end
