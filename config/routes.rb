Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :clients
  devise_for :staffs
end
