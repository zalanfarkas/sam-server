class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :sam_student_id
      t.string :first_name
      t.string :last_name
      t.string :card_id

      t.timestamps
    end
    add_index :students, :sam_student_id, unique: true
  end
end
