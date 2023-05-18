class FavoritesController < ApplicationController
  
  def create
    @lot = Lot.find(params[:lot_id])
    @user = current_user
    @favorites = Favorite.new(lot: @lot, user: @user)
    
    @favorites.save! 
    redirect_to @lot, notice: "Lote favoritado!"
  end

  def destroy
    @lot = Lot.find(params[:lot_id])
    @user = current_user
    @favorites = Favorite.find_by(lot: @lot, user: @user)

    @favorites.destroy!

    redirect_to @lot, notice: "Lote desfavoritado!"
  end
end