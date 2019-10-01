class HardwareSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :kind, :number
end
