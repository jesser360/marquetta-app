class AddTokenToCardProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :card_products, :token, :string
  end
end
