class Ctgnme < ActiveRecord::Base
  self.table_name = "ctgnme"

  has_many :fdes, foreign_key: "Food_Category_Code", primary_key: "Food_Category_Code"
  has_many :buygd, through: :fdes 
end
