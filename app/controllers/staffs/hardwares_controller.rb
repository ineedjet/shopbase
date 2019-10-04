class Staffs::HardwaresController < ApplicationController
  before_action :authenticate_staff!

  def index
    @hardwares = Hardware.all.order(created_at: :desc)
    render json: HardwareSerializer.new(@hardwares).serialized_json
  end

  def show
    @hardware = Hardware.find(params[:id])
    render json: HardwareSerializer.new(@hardware).serialized_json, status: :ok
  end

  def create
    @hardware = Hardware.new(hardware_params)

    if @hardware.save
      render json: HardwareSerializer.new(@hardware).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    @hardware = Hardware.find(params[:id])

    if @hardware.update(hardware_params)
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

  def destroy
    @hardware = Hardware.find(params[:id])
    @hardware.destroy

    head :no_content
  end

  private

  def hardware_params
    params.require(:hardware).permit(:name, :kind, :number)
  end

  def errors_json
    @hardware.errors.as_json
  end
end
