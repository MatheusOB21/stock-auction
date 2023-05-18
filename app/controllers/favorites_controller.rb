class FavoritesController < ApplicationController
  before_action :authenticate_user!, only:[:index, :create, :destroy]
  before_action :lot_and_user, only:[:create, :destroy]
  
  def index
    @favorites = current_user.favorites
  end
  
  def create
    @favorites = Favorite.new(lot: @lot, user: @user)
    
    @favorites.save! 
    redirect_to @lot, notice: "Lote favoritado!"
  end

  def destroy
    @favorites = Favorite.find_by(lot: @lot, user: @user)

    @favorites.destroy!

    redirect_to @lot, notice: "Lote desfavoritado!"
  end

  private

  def lot_and_user
    @lot = Lot.find(params[:lot_id])
    @user = current_user
  end
end