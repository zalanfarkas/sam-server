# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

class CreateAbsenceCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :absence_certificates do |t|
      t.references :student, foreign_key: true
      t.references :course, foreign_key: true
      t.string :certificate_type

      t.timestamps
    end
  end
end
