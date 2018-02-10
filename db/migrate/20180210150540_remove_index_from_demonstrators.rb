class RemoveIndexFromDemonstrators < ActiveRecord::Migration[5.1]
  def change
    remove_index :demonstrators, :sam_demonstrator_id
  end
end
