class Staffs::ClientsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @clients = Client.all.order(created_at: :desc)
    render json: @clients.to_json(only: [:id, :fullname, :phone, :email])
  end

  def create
    @client = Client.new(client_params.merge(password: Devise.friendly_token))

    if @client.save
      render json: @client.to_json(only: [:id, :fullname, :phone, :email]), status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @client = Client.new(client_params)

    if @client.valid?
      render json: client_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:fullname, :phone, :email)
  end

  def errors_json
    @client.errors.as_json
  end

  def serialized_client
  end
end
