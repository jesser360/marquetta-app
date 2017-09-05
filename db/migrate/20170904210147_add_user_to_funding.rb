class AddUserToFunding < ActiveRecord::Migration[5.1]
  def change
    add_reference :fundings, :user, foreign_key: true
    add_reference :fundings, :funding_source, foreign_key: true
  end
end
