class CreateBygdlnks < ActiveRecord::Migration
  def change
    create_table :bygdlnk do |t|
      t.integer :CN_Code
      t.integer :Buying_Guide_Code
      t.datetime :Date_added
      t.datetime :Last_modified
      t.text :status
    end
  end
end
