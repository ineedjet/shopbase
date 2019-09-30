class Staffs::StaffsController < ApplicationController
  def index
    @staffs = Staff.all.order(created_at: :desc)
    render json: StaffSerializer.new(@staffs).serialized_json
  end

  def create
    @staff = Staff.new(staff_params.merge(password: Devise.friendly_token))

    if @staff.save
      render json: StaffSerializer.new(@staff).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    @staff = Organization.find(params[:id])
    @staff.destroy

    head :no_content
  end

  private

  def staff_params
    params.require(:staff).permit(:fullname, :phone, :email)
  end

  def errors_json
    @staff.errors.as_json
  end
end
