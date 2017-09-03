class CreateCardProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :card_products do |t|

      t.timestamps
    end
  end
end
