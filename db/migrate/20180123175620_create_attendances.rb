class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.references :student, foreign_key: true, type: :string
      t.references :practical, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
