class AddDelinquentAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :delinquent_at, :datetime
  end
end
