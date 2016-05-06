class AddIndexes < ActiveRecord::Migration
  def change
    add_index :nutval, :Nutrient_Code
    add_index :nutval, :CN_Code
    
    add_index :nutdes, :Nutrient_Code

    add_index :buygd, :Buying_Guide_Code

    add_index :bygdlnk, :Buying_Guide_Code
    add_index :bygdlnk, :CN_Code

    add_index :fdes, :Food_Category_Code
    add_index :fdes, :CN_Code

    add_index :ctgnme, :Food_Category_Code

    add_index :wght, :CN_Code
  end
end
