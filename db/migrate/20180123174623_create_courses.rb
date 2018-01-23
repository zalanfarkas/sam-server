class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, id: false, primary_key: :course_id do |t|
      t.string :course_id
      t.string :course_title
      t.references :staff, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
