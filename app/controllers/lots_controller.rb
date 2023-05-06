class LotsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :show, :pendentes]
  before_action :admin_page, only:[:new, :create, :show, :pendentes]

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

  def pendents
    @lots = Lot.where(status: "pending")
  end

  def aprovated
    @lot = Lot.find(params[:id])
    if current_user.id != @lot.user_id
      @lot.aprovated!
      redirect_to @lot, notice: "Lote aprovado com sucesso"
    else
      redirect_to @lot, notice: "Você não pode aprovar lotes criados pelo seu usuário"
    end
  end

  private

  def admin_page 
    if current_user.is_admin 
    else
      redirect_to root_path, notice:  "Você não tem acesso a essa página"
    end
  end
end