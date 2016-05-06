class CreateNutvals < ActiveRecord::Migration
  def change
    create_table :nutval do |t|
      t.integer :CN_Code
      t.integer :Nutrient_Code
      t.decimal :Nutrient_Value, precision: 64, scale: 12
      t.integer :Value_Type_Code
      t.timestamp :Date_added
      t.timestamp :Last_modified
      t.text :Status
    end
  end
end
