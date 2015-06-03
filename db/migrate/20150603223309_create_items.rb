class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.datetime :date, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
