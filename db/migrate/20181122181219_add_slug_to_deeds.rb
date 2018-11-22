class AddSlugToDeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :deeds, :slug, :string
    add_index :deeds, :slug, unique: true
  end
end
