class User < ActiveRecord::Base
  has_many :items, dependent: :destroy

  def card_name
    "#{first_name} #{last_name}"
  end

  def card_desc
    desc_string = "Balance: #{balance}"
    unless delinquent_at.nil?
      desc_string += "; Delinquent as of #{delinquent_at}"
    end

    desc_string
  end
end
