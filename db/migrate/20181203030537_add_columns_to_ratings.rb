class AddColumnsToRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :score, :integer
    add_column :ratings, :body, :text
  end
end
