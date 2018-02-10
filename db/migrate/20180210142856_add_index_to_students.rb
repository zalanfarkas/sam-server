class AddIndexToStudents < ActiveRecord::Migration[5.1]
  def change
    add_index :students, :card_id, unique: true
  end
end
