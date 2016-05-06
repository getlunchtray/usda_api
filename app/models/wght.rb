class Wght < ActiveRecord::Base
  self.table_name = "wght"

  belongs_to :bygdlnk, foreign_key: "CN_Code", primary_key: "CN_Code"
  has_one :buygd, through: :bygdlnk
end
