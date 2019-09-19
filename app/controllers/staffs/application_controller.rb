class Staffs::ApplicationController < ApplicationController
  layout 'staff'
  
  before_action :authenticate_staff!
  
  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Staff!' }
      end
    end
  end

  private

  def authenticate_staff!
    if user_signed_in? && current_user.class == Staff
      super
    else
      redirect_to new_staff_session_path, alert: 'Access denied. Please sign in.'
    end
  end
end
