class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :kind, :inn, :ogrn
end
