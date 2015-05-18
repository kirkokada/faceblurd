class AddSlugToImages < ActiveRecord::Migration
  def change
    add_column :images, :slug, :string
    add_index :images, :slug, unique: true
  end
end
