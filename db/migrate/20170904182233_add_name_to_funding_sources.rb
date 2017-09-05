class AddNameToFundingSources < ActiveRecord::Migration[5.1]
  def change
    add_column :funding_sources, :name, :string
    add_column :funding_sources, :token, :string
    add_column :funding_sources, :account, :string
  end
end
