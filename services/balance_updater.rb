class BalanceUpdater
  LATE_PENALTY = 5
  DELINQUENT_THRESHOLD = -100

  def initialize(item)
    @item = item
    @user = item.user
  end

  def process_balance
    if @item.item_type == 'fee'
      @user.balance -= @item.amount
    else
      @user.balance += @item.amount
    end
  end

  def process_late_fee
    unless @user.balance >= DELINQUENT_THRESHOLD
      fee = ((Time.now - @user.delinquent_at)/(60*60*24)).floor * LATE_PENALTY
      @user.delinquent_at = Time.now
      @user.balance -= fee
    end
  end

  def update_user_balance
    process_late_fee
    process_balance

    if @user.balance > DELINQUENT_THRESHOLD
      @user.delinquent_at = nil
    elsif @user.delinquent_at.nil?
      @user.delinquent_at = Time.now
    end

    @user.save
  end
end
