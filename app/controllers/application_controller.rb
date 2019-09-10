class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.class == Client::Client
      path = Rails.application.routes.url_helpers.clients_app_show_path(resource)
    elsif resource.class == Staff::Staff
      path = Rails.application.routes.url_helpers.staffs_app_show_path(resource)
    end
    path || root_path
  end
end
