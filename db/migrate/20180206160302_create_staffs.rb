class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :sam_staff_id
      t.string :first_name
      t.string :last_name
      t.string :card_id

      t.timestamps
    end
    add_index :staffs, :sam_staff_id, unique: true
  end
end
