class CreateNutdes < ActiveRecord::Migration
  def change
    create_table :nutdes do |t|
      t.integer :Nutrient_Code
      t.text :Nutrient_Description
      t.text :Nutrient_Desc_abrv
      t.text :Nutrient_Unit
      t.datetime :Date_added
      t.datetime :Last_modified
      t.text :Status
    end
  end
end
