class ItemsController < ApplicationController
  protect_from_forgery except: :create

  def create
    @item = Item.create item_params.merge user_id: params[:user_id]
    BalanceUpdater.new(@item).update_user_balance
    TrelloUpdater.new(@item.user).update

    respond_to do |format|
      format.json { render 'create.js' }
    end
  end

  private

  def item_params
    params.permit(:item_type, :amount, :date)
  end
end
