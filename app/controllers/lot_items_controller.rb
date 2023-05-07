class LotItemsController < ApplicationController
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
end