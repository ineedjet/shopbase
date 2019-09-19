class Clients::ApplicationController < ApplicationController
  layout 'client'
  
  before_action :authenticate_client!
  
  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Client!' }
      end
    end
  end

  private

  def authenticate_client!
    if user_signed_in? && current_user.class == Client
      super
    else
      redirect_to new_client_session_path, alert: 'Access denied. Please sign in.'
    end
  end
end
