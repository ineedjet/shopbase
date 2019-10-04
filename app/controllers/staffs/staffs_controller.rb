class Staffs::StaffsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @staffs = Staff.all.order(created_at: :desc)
    render json: StaffSerializer.new(@staffs).serialized_json
  end

  def show
    @staff = Staff.find(params[:id])
    render json: StaffSerializer.new(@staff).serialized_json, status: :ok
  end

  def create
    @staff = Staff.new(staff_params.merge(password: Devise.friendly_token))

    if @staff.save
      render json: StaffSerializer.new(@staff).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    @staff = Staff.find(params[:id])

    if @staff.update(staff_params)
      render json: StaffSerializer.new(@staff).serialized_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    head :no_content
  end

  def resetpass
    Staff.find(params[:id]).send_reset_password_instructions
  end

  private

  def staff_params
    params.require(:staff).permit(:fullname, :position, :email)
  end

  def errors_json
    @staff.errors.as_json
  end
end
