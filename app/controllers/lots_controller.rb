class LotsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :show]
  before_action :admin_page, only:[:new, :create, :show]

  def new 
    @lot = Lot.new
  end

  def create
    lot_params = params.require(:lot).permit(:code, :start_date, :limit_date, :minimal_val, :minimal_difference)
    @lot = Lot.new(lot_params)
    @lot.user = current_user

    if @lot.save 
      redirect_to @lot, notice: "Lote cadastrado com sucesso"
    end
  end

  def show
    lot_id = params[:id]
    @lot = Lot.find(lot_id)
  end
  private

  def admin_page 
  if current_user.is_admin 
  else
    redirect_to root_path, notice:  "Você não tem acesso a essa página"
  end
  end
end