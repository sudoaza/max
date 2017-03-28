class CreateFeatureds < ActiveRecord::Migration
  def change
    create_table :featureds do |t|
      t.string :history
      t.references :art
      t.references :song

      t.timestamps null: false
    end
  end
end
