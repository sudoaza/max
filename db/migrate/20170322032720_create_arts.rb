class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.attachment :image
      t.timestamps null: false
    end
  end
end
