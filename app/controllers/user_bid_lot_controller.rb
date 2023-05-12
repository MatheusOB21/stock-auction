class UserBidLotController < ApplicationController
  before_action :authenticate_user!, only:[:index]
  def index
    @lots_winners = Lot.joins(:user_bid_lots).where("user_bid_lots.user_id = ? and user_bid_lots.status = ?", current_user.id, 2)
  end
end