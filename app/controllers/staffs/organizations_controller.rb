class Staffs::OrganizationsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @organizations = Organization.all.order(created_at: :desc)
    render json: OrganizationSerializer.new(@organizations).serialized_json
  end

  def show
    @organization = Organization.find(params[:id])
    render json: OrganizationSerializer.new(@organization).serialized_json, status: :ok
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: OrganizationSerializer.new(@organization).serialized_json, status: :created
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      render json: OrganizationSerializer.new(@organization).serialized_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def validate
    @organization = Organization.new(organization_params)

    if @organization.valid?
      render json: organization_params.as_json, status: :ok
    else
      render json: errors_json, status: :unprocessable_entity
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    head :no_content
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :kind, :inn, :ogrn, client_ids: [])
  end

  def errors_json
    @organization.errors.as_json
  end
end
