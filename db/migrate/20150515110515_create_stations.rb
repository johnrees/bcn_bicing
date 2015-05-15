class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :kind
      t.float :latitude
      t.float :longitude
      t.string :street_number
      t.string :street_name
      t.integer :height

      t.string :status
      t.integer :slots_count
      t.integer :bikes_count
      t.datetime :last_polled_at

      t.timestamps null: false
    end
    add_index :stations, [:latitude, :longitude], unique: true
    add_index :stations, [:id, :last_polled_at], unique: true
  end
end
