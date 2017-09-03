class AddStateToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :state, :boolean
  end
end
