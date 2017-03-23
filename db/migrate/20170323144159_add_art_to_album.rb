class AddArtToAlbum < ActiveRecord::Migration
  def change
    add_reference :albums, :art, foreign_key: true
  end
end
