class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :version

      t.timestamps null: false
    end
  end
end
