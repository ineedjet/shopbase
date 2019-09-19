class Staffs::ApplicationController < ApplicationController
  before_action :authenticate_staff!
  
  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        render json: { data: 'Hello Staff!' }
      end
    end
  end
end
