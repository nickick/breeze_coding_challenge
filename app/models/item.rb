class Item < ActiveRecord::Base
  belongs_to :user

  validates :amount, :item_type, :date, :user_id, presence: true
end
