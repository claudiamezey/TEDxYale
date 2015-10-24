class AddNominationToApplications < ActiveRecord::Migration
  change_table :applications do |t|
      t.text :nomination
    end
end
