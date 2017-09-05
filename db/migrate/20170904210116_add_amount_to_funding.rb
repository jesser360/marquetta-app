class AddAmountToFunding < ActiveRecord::Migration[5.1]
  def change
    add_column :fundings, :amount, :integer
    add_column :fundings, :currency, :string
  end
end
