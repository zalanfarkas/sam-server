class AddIndexToStaffs < ActiveRecord::Migration[5.1]
  def change
    add_index :staffs, :card_id, unique: true
  end
end
