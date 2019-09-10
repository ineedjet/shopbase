Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :clients, class_name: 'Client::Client', path: 'client'
  devise_for :staffs,  class_name: 'Staff::Staff',   path: 'staff'
end
