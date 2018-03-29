# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class CreateEnrolments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolments do |t|
      t.references :course, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
