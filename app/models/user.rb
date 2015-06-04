class User < ActiveRecord::Base
  has_many :items, dependent: :destroy

  def card_name
    "[##{id}] #{first_name} #{last_name} - #{card_desc}"
  end

  def card_desc
    desc_string = "balance: #{balance}"
    unless delinquent_at.nil?
      desc_string += "; delinquent as of #{delinquent_at}"
    end

    desc_string
  end
end
