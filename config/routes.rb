Rails.application.routes.draw do
  root "pages#home"
  get "test", to: "pages#test"

  devise_for :clients, path: "/clients/devise"
  devise_for :staffs, path: "/staffs/devise"

  namespace :clients do
    get "/", to: "application#index"
    mount_devise_token_auth_for "Client", at: "auth", skip: %i[registrations passwords]
  end

  namespace :staffs do
    get "/", to: "application#index"
    mount_devise_token_auth_for "Staff", at: "auth", skip: %i[registrations passwords]

    resources :clients, only: %i[index create], constraints: { format: "json" } do
      collection do
        post :validate
      end
    end
    resources :organizations, only: %i[index create destroy], constraints: { format: "json" }
    resources :staffs, only: %i[index create destroy], constraints: { format: "json" }
  end
end
