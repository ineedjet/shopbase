module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_client
      flash.clear
      redirect_to(clients_app_show_path(current_client.id)) && return
    elsif current_staff
      flash.clear
      redirect_to(staffs_app_show_path(current_staff.id)) && return
    end
  end
end
