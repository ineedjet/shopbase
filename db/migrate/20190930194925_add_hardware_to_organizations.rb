class AddHardwareToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_reference :devices, :organization, foreign_key: true
  end
end
