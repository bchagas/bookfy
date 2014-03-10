class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_id
      t.string :album_id

      t.timestamps
    end
  end
end
