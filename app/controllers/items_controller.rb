class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new]
  before_action :admin_page, only:[:new, :create, :show]
  
  def new   
    @item = Item.new
  end

  def create
    item_params = params.require(:item).permit(:name, :description, :weight, :depth, :height, :width, :product_category, :image)
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item cadastrado com sucesso'
    else
      flash.now[:notice] = 'Item não cadastrado'
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end