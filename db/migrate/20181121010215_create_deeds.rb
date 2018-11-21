class CreateDeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :deeds do |t|
      t.string :title
      t.string :body
      t.integer :money_required
      t.integer :money_raised
      t.string :image_url
      t.string :location

      t.timestamps
    end
  end
end
