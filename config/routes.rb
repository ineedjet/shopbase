Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :clients, class_name: 'Client::Client', module: 'clients'
  devise_for :staffs,  class_name: 'Staff::Staff',   module: 'staffs'
end
