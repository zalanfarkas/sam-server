# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.references :student, foreign_key: true
      t.references :practical, foreign_key: true

      t.timestamps
    end
  end
end
