class AddProductNameToCardProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :card_products, :product_name, :string
  end
end
