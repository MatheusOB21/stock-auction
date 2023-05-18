class FavoritesController < ApplicationController
  def create
    @lot = Lot.find(params[:lot_id])
    @user = current_user
    @favorites = Favorite.new(lot: @lot, user: @user)
    
    @favorites.save! 
    redirect_to @lot, notice: "Lote favoritado!"
  end
end