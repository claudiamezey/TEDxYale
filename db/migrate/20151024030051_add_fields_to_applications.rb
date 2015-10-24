class AddFieldsToApplications < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.text :title
      t.text :description
      t.text :qualification
      t.text :favorite
    end
  end
end
