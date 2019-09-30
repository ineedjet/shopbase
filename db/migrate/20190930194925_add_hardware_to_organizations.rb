class AddHardwareToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_reference :organizations, :hardware, foreign_key: true
  end
end
