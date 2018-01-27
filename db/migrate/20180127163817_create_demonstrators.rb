class CreateDemonstrators < ActiveRecord::Migration[5.1]
  def change
    create_table :demonstrators, id: false, primary_key: :demonstrator_id do |t|
      t.string :demonstrator_id
      t.references :course, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
