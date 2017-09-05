class AddActiveToFundingSources < ActiveRecord::Migration[5.1]
  def change
    add_column :funding_sources, :active, :boolean
  end
end
