class CreateFunds < ActiveRecord::Migration[5.2]
  def change
    create_table :funds do |t|
      t.references :user, foreign_key: true
      t.references :deed, foreign_key: true

      t.timestamps
    end
  end
end
