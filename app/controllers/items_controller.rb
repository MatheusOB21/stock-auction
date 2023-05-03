class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new]
  def new   
    if current_user.is_admin 
      @item = Item.new
    else
      redirect_to root_path, notice:  "Você não tem acesso a essa página"
    end
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