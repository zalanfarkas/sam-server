class AddFingerprintTemplateToStaff < ActiveRecord::Migration[5.1]
  def change
    add_column :staffs, :fingerprint_template, :text
  end
end
