class Fdes < ActiveRecord::Base
  self.table_name = "fdes"

  has_many :wghts, foreign_key: "CN_Code", primary_key: "CN_Code"
  has_many :nutvals, foreign_key: "CN_Code", primary_key: "CN_Code"

  has_many :nutdes, through: :nutvals

  belongs_to :bygdlnk, foreign_key: "CN_Code", primary_key: "CN_Code"
  has_one :buygd, through: :bygdlnk
  belongs_to :ctgnme, foreign_key: "Food_Category_Code", primary_key: "Food_Category_Code"
end
