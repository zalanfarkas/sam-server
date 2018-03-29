# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class RemoveIndexFromDemonstrators < ActiveRecord::Migration[5.1]
  def change
    remove_index :demonstrators, :sam_demonstrator_id
  end
end
