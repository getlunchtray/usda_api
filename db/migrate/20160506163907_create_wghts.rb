class CreateWghts < ActiveRecord::Migration
  def change
    create_table :wght do |t|
      t.integer :CN_Code
      t.integer :Weights_Sequence_Number
      t.decimal :Amount, precision: 64, scale: 12
      t.text :Measure_desc
      t.decimal :Gram_Weight, precision: 64, scale: 12
      t.timestamp :Date_added
      t.timestamp :Last_modified
      t.text :Status
    end
  end
end
