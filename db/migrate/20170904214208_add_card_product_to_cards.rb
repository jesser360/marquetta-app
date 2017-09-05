class AddCardProductToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :card_product, foreign_key: true
  end
end
