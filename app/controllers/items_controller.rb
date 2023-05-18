class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:index, :new, :create, :edit, :update]
  before_action :admin_page, only:[:index,:show, :new, :create, :edit, :update]
  
  def index
    @items_available = Item.where.missing(:lot_item)
  end

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    item_params = params.require(:item).permit(:name, :description, :weight, :depth, :height, :width, :product_category, :image)
    if @item.update(item_params)
      redirect_to @item, notice: "Item editado com sucesso"
    else
      flash.now[:notice] = "Item não pode ser editado"
      render 'edit'
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end