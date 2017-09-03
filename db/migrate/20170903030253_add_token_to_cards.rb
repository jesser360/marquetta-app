class AddTokenToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :token, :string
    add_column :cards, :last_four, :integer
    add_column :cards, :expiration, :integer
  end
end
