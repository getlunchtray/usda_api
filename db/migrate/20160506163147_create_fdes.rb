class CreateFdes < ActiveRecord::Migration
  def change
    create_table :fdes do |t|
      t.integer :Food_Category_Code
      t.text :Descriptor
      t.text :Abbr_Desc
      t.integer :CN_Code      
      t.text :Product_Code
      t.text :MFR_Name
      t.text :Commodity_Or_Recipe_Code
      t.integer :Source_Code
      t.datetime :Date_added
      t.datetime :Last_modified
      t.text :Status
      t.text :Form_of_Food
    end
  end
end
