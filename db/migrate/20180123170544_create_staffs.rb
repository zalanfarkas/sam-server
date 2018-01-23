class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs, id: false, primary_key: :staff_id do |t|
      t.string :staff_id
      t.string :first_name
      t.string :last_name
      t.string :card_id

      t.timestamps
    end
  end
end
