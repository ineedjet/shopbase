class StaffSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :fullname, :position
end
