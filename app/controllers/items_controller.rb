class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new]
  def new   
    if current_user.is_admin 
      @item = Item.new
      @product_category = ProductCategory.all
    else
      redirect_to root_path, notice:  "Você não tem acesso a essa página"
    end
  end

end