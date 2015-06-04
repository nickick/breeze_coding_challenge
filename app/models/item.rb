class Item < ActiveRecord::Base
  ITEM_TYPE_OPTIONS = ['fee', 'earning']
  belongs_to :user

  validates :amount, :item_type, :date, :user_id, presence: true

  validates :item_type, inclusion: { in: ITEM_TYPE_OPTIONS }
end
