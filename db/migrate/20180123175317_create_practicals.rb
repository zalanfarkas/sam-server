class CreatePracticals < ActiveRecord::Migration[5.1]
  def change
    create_table :practicals do |t|
      t.string :practical_id
      t.references :course, foreign_key: true, type: :string
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
