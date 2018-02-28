class AddFingerprintTemplateToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :fingerprint_template, :text
  end
end
