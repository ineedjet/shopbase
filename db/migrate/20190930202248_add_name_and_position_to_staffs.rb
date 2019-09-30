class AddNameAndPositionToStaffs < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :fullname, :string
    add_column :staffs, :position, :string
  end
end
