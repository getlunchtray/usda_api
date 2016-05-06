class Nutval < ActiveRecord::Base
  self.table_name = "nutval"
  
  belongs_to :nutdes, foreign_key: "Nutrient_Code", primary_key: "Nutrient_Code"
  belongs_to :bygdlnk, foreign_key: "CN_Code", primary_key: "CN_Code"
  has_one :buygd, through: :bygdlnk
end
