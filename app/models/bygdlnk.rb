class Bygdlnk < ActiveRecord::Base
  self.table_name = "bygdlnk"
  
  belongs_to :buygd, foreign_key: "Buying_Guide_Code", primary_key: "Buying_Guide_Code"

  has_many :nutvals, foreign_key: "CN_Code", primary_key: "CN_Code"
  has_many :nutdes, through: :nutvals
  has_one :fdes, foreign_key: "CN_Code", primary_key: "CN_Code", class_name: "Fdes"
  has_one :ctgnme, through: :fdes
  has_many :wghts, foreign_key: "CN_Code", primary_key: "CN_Code"
end
