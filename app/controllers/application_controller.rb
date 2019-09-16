class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  devise_group :user, contains: [:client, :staff]

  def after_sign_in_path_for(resource)
    if resource.class == Client
      clients_app_show_path(resource)
    elsif resource.class == Staff
      staffs_app_show_path(resource)
    end || root_path
  end
end
