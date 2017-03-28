class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :playlist_songs, :playlist_id
    add_index :playlist_songs, :song_id
    add_index :featureds, :art_id
    add_index :featureds, :song_id
    add_index :albums, :artist_id
    add_index :albums, :art_id
  end
end
