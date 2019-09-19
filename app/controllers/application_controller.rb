class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  devise_group :user, contains: [:client, :staff]

  def after_sign_in_path_for(resource)
    if resource.class == Client
      clients_root_path
    elsif resource.class == Staff
      staffs_root_path
    end || root_path
  end
end
