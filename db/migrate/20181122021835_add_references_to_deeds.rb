class AddReferencesToDeeds < ActiveRecord::Migration[5.2]
  def change
    add_reference :deeds, :user, foreign_key: true
  end
end
