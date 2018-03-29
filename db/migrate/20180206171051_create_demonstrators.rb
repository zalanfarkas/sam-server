# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class CreateDemonstrators < ActiveRecord::Migration[5.1]
  def change
    create_table :demonstrators do |t|
      t.string :sam_demonstrator_id
      t.references :practical, foreign_key: true

      t.timestamps
    end
    add_index :demonstrators, :sam_demonstrator_id, unique: true
  end
end
