class RemoveImageUpdatedAtFromArts < ActiveRecord::Migration
  def change
    remove_column :arts, :image_updated_at, :datetime
  end
end
