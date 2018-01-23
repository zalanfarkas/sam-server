class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students, id: false, primary_key: :student_id do |t|
      t.string :student_id
      t.string :first_name
      t.string :last_name
      t.string :card_id

      t.timestamps
    end
  end
end
