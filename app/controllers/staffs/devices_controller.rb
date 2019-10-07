class Staffs::DevicesController < ApplicationController
  before_action :authenticate_staff!

  def index
    @devices = Device.all.order(created_at: :desc)
    render json: DeviceSerializer.new(@devices).serialized_json
  end

  def show
    @device = Device.find(params[:id])
    render json: DeviceSerializer.new(@device).serialized_json, status: :ok
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      render json: DeviceSerializer.new(@device).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    @device = Device.find(params[:id])

    if @device.update(device_params)
      render json: DeviceSerializer.new(@device).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @device = Device.new(device_params)

    if @device.valid?
      render json: device_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    head :no_content
  end

  private

  def device_params
    params.require(:device).permit(:name, :kind, :number)
  end

  def errors_json
    @device.errors.as_json
  end
end
