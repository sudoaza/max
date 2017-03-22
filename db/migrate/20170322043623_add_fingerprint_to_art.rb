class AddFingerprintToArt < ActiveRecord::Migration
  def change
    add_column :arts, :image_fingerprint, :string
    add_index :arts, :image_fingerprint, unique: true
  end
end
