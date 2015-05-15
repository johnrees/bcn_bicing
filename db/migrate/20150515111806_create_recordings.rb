class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.belongs_to :station, foreign_key: true
      t.integer :slots_count
      t.integer :bikes_count
      t.string :status
      t.datetime :polled_at
    end
    add_index :recordings, [:station_id, :polled_at], unique: true
  end
end
