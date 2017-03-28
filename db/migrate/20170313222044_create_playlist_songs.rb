class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.references :playlist
      t.references :song

      t.timestamps null: false
    end
  end
end
