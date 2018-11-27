class AddAssmStateToDeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :deeds, :aasm_state, :string 
  end
end
