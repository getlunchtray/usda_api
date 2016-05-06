class Ctgnme < ActiveRecord::Base
  self.table_name = "ctgnme"

  has_many :fdes, foreign_key: "Food_Category_Code", primary_key: "Food_Category_Code", class_name: "Fdes"
  has_many :buygds, through: :fdes 
end
