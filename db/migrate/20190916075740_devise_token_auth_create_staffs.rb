class DeviseTokenAuthCreateStaffs < ActiveRecord::Migration[6.0]
  def change
    change_table(:staffs) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Recoverable
      t.boolean :allow_password_change, default: false

      ## Tokens
      t.json :tokens
    end

    add_index :staffs, [:uid, :provider], unique: true
  end
end
