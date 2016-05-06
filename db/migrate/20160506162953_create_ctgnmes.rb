class CreateCtgnmes < ActiveRecord::Migration
  def change
    create_table :ctgnme do |t|
      t.integer :Food_Category_Code
      t.text :Category_Description
      t.datetime :Date_added
      t.datetime :Last_modified
      t.text :Status
    end
  end
end
