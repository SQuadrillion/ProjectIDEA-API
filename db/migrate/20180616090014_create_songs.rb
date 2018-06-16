class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :song_name
      t.string :artist_name
      t.string :artwork_url
      t.string :music_url
      t.integer :time

      t.timestamps
    end
  end
end
