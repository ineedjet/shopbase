class Staffs::OrganizationsController < ApplicationController
  before_action :authenticate_staff!

  def index
    find_organizations = FindOrganizations.new(Organization.all, params)
    @organizations = find_organizations.call(search_permitted_params)
    render json: OrganizationSerializer.new(@organizations, { meta: find_organizations.meta }).serialized_json
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
    params.require(:organization).permit(:name, :kind, :inn, :ogrn, client_ids: [], device_ids: [])
  end

  def search_permitted_params
    params.permit(:filter, :sortBy, :descending, :page, :rowsPerPage, :rowsNumber)
  end

  def errors_json
    @organization.errors.as_json
  end
end
