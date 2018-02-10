class AddIndexToDemonstrators < ActiveRecord::Migration[5.1]
  def change
    add_index :demonstrators, :sam_demonstrator_id
  end
end
