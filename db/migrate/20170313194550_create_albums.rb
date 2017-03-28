class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.references :artist

      t.timestamps null: false
    end
  end
end
