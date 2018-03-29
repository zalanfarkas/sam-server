# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class AddPictureToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :picture, :string
  end
end
