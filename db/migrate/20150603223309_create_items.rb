class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :date
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
