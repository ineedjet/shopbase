class CreateHardwares < ActiveRecord::Migration[6.0]
  def change
    create_table :hardwares do |t|
      t.string :name
      t.string :kind
      t.string :number

      t.timestamps
    end
  end
end
