class CreateBuygds < ActiveRecord::Migration
  def change
    create_table :buygd do |t|
      t.integer :Food_Category_Code
      t.text :Food_Description
      t.integer :Buying_Guide_Code
      t.integer :Sequence_Number
      t.text :Purchase_Unit
      t.text :Preparation_Desc
      t.decimal :Edible_Portion_Amt, precision: 64, scale: 12
      t.text :Edible_Portion_Measure
      t.datetime :Date_added
      t.datetime :Last_modified
      t.text :Status
    end
  end
end
