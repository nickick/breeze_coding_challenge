class TrelloUpdater
  require 'trello'
  BALANCE_TRACKER_BOARD_ID = '54ee82fae62c0eb8da6d3115'
  OPEN_LIST_ID = '54ee82fe28c214334d9e10ec'
  RESOLVED_LIST_ID = '54ee82ff6d371d305a8f7ee7'

  Trello.configure do |config|
    config.developer_public_key = Rails.configuration.trello.DEVELOPER_PUBLIC_KEY
    config.member_token = Rails.configuration.trello.MEMBER_TOKEN
  end

  @@balance_tracker_board = Trello::Board.find(BALANCE_TRACKER_BOARD_ID)
  @@open_list = Trello::List.find(OPEN_LIST_ID)
  @@resolved_list = Trello::List.find(RESOLVED_LIST_ID)

  def initialize(user)
    @user = user
  end

  def find_or_create_user_card
    card = @@balance_tracker_board.cards.select do |card|
      card.name =~ /\[\##{@user.id}\]/
    end.first

    if card.nil? && @user.delinquent_at
      card = Trello::Card.create(name: @user.card_name, desc: @user.card_desc, list_id: OPEN_LIST_ID)
    end

    card
  end

  def update
    card = find_or_create_user_card
    return false unless card

    card.name = @user.card_name
    card.save

    # assumes balance has been updated already and that delinquent_at
    # will be deleted for non-delinquent users
    if @user.delinquent_at.nil?
      card.move_to_list(@@resolved_list) if card.list == @@open_list
    else
      card.move_to_list(@@open_list) if card.list == @@resolved_list
    end
  end
end
