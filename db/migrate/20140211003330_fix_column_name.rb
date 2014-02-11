class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :photos, :name, :url
  end

  def down
    rename_column :photos, :url, :name
  end
end
