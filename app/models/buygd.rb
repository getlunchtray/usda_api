class Buygd < ActiveRecord::Base
  self.table_name = "buygd"

  has_many :bygdlnks, foreign_key: "Buying_Guide_Code", primary_key: "Buying_Guide_Code"
  has_many :nutvals, through: :bygdlnks
  has_many :fdes, through: :bygdlnks
  has_many :wghts, through: :bygdlnks
end
