# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class AddLocationToPracticals < ActiveRecord::Migration[5.1]
  def change
    add_column :practicals, :location, :string
  end
end
