class CreateAlbumphotos < ActiveRecord::Migration
  def change
    create_table :albumphotos do |t|
      t.integer :photo_id
      t.integer :album_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
