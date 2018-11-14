class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :teama
      t.string :teamb
      t.string :place
      t.string :myteam
      t.string :artist
      t.text :livetitle
      t.string :logo
      t.integer :apoint
      t.integer :bpoint
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
