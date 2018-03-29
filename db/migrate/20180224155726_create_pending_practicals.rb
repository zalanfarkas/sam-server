# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class CreatePendingPracticals < ActiveRecord::Migration[5.1]
  def change
    create_table :pending_practicals do |t|
      t.string :raspberry_pi_id
      t.references :practical, foreign_key: true

      t.timestamps
    end
    add_index :pending_practicals, :raspberry_pi_id, unique: true
  end
end
