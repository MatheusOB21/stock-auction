class FavoritesController < ApplicationController
  before_action :authenticate_user!, only:[:index, :create, :destroy]
  
  def index
    @favorites = current_user.favorites
  end
  
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