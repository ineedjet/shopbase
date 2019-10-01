class Staffs::HardwaresController < ApplicationController
  before_action :authenticate_staff!

  def index
    @hardwares = Hardware.all.order(created_at: :desc)
    render json: HardwareSerializer.new(@hardwares).serialized_json
  end

  def create
    @hardware = Hardware.new(hardware_params)

    if @hardware.save
      render json: HardwareSerializer.new(@hardware).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @hardware = Hardware.new(hardware_params)

    if @hardware.valid?
      render json: hardware_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  private

  def hardware_params
    params.require(:hardware).permit(:name, :kind, :number)
  end

  def errors_json
    @hardware.errors.as_json
  end
end
