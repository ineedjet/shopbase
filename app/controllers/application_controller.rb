class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.class == Client::Client
      clients_app_show_path(resource)
    elsif resource.class == Staff::Staff
      staffs_app_show_path(resource)
    end || root_path
  end
end
