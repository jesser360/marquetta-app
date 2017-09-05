class CreateFundings < ActiveRecord::Migration[5.1]
  def change
    create_table :fundings do |t|

      t.timestamps
    end
  end
end
