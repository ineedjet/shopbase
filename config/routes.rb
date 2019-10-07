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

    resources :staffs, only: %i[index show create update destroy], constraints: { format: "json" } do
      member do
        post :resetpass
      end
    end
    resources :clients, only: %i[index show create update destroy], constraints: { format: "json" } do
      collection do
        post :validate
      end
      member do
        post :resetpass
      end
    end
    resources :organizations, only: %i[index show create update destroy], constraints: { format: "json" }
    resources :devices, only: %i[index show create update destroy], constraints: { format: "json" }

    get "/dashboard/*slug", to: "application#index"
  end
end
