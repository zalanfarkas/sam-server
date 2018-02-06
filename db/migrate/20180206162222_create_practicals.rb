class CreatePracticals < ActiveRecord::Migration[5.1]
  def change
    create_table :practicals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
