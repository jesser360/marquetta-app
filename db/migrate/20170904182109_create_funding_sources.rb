class CreateFundingSources < ActiveRecord::Migration[5.1]
  def change
    create_table :funding_sources do |t|

      t.timestamps
    end
  end
end
