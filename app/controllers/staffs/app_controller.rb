class Staffs::AppController < ApplicationController
  before_action :authenticate_staff!
  
  def show
  end
end
