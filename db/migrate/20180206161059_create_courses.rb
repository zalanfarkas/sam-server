class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :sam_course_id
      t.string :course_title
      t.references :staff, foreign_key: true

      t.timestamps
    end
    add_index :courses, :sam_course_id, unique: true
  end
end
