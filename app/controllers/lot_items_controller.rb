class LotItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :destroy]
  before_action :admin_page, only:[:new, :create, :destroy]
  def new
    @lot = Lot.find(params[:lot_id])

    @items = Item.where.missing(:lot_item)

    @lot_item = LotItem.new()
  end

  def create
    @lot = Lot.find(params[:lot_id])
    lot_item_params = params.require(:lot_item).permit(:item_id)
    @lot_item = LotItem.new(lot_item_params)
    @lot_item.lot = @lot
    @lot_item.save!
    redirect_to @lot, notice: "Item adicionado com sucesso"
  end
  def destroy
    @lot_item = LotItem.find(params[:id])
    @lot = Lot.find(params[:lot_id])
    @lot_item.destroy!
    redirect_to @lot, notice: "Item removido com sucesso"
  end
end