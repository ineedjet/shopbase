class AddHardwareToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_reference :hardwares, :organization, foreign_key: true
  end
end
