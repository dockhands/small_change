class AddCompletedBodyToDeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :deeds, :completed_body, :text
  end
end
