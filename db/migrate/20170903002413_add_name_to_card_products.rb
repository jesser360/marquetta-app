class AddNameToCardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :card_products, :name, :string
    add_column :card_products, :start_date, :string
    add_column :card_products, :active, :boolean
  end
end
