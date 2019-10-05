class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :fullname, :phone, :organizations
end
