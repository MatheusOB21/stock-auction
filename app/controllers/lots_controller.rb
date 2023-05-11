class LotsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :pendents, :aprovated, :bid, :finished, :finished_details]
  before_action :admin_page, only:[:new, :create, :pendents, :finished, :finished_details]

  def new 
    @lot = Lot.new
  end

  def create
    lot_params = params.require(:lot).permit(:code, :start_date, :limit_date, :minimal_val, :minimal_difference)
    @lot = Lot.new(lot_params)
    @lot.user = current_user

    @lot.code = @lot.code.upcase 

    if @lot.save 
      redirect_to @lot, notice: "Lote cadastrado com sucesso"
    else
      flash.now[:notice] = "Lote não cadastrado"
      render 'new'
    end
  end

  def show
    lot_id = params[:id]
    @lot = Lot.find(lot_id)

    if @lot.aprovated? && !@lot.finished_bids
    elsif user_signed_in?
      if current_user.is_admin
      else
      redirect_to root_path, notice: "Você não tem acesso a essa página"
      end
    else 
      redirect_to root_path, notice: "Você não tem acesso a essa página" 
    end  
  end

  def pendents
    @lots_pendents = Lot.where(status: "pending")
  end
  
  def finished
    @lots_finished = Lot.where(["limit_date < ?", Date.today])
  end

  def closed
    @lot = Lot.find(params[:id])
    @lot.closed!
    @lot.last_bid.won!
    
    @lot.user_bid_lots.where(status: 'bid').each do |lot|
      lot.loser!
    end
    
    redirect_to @lot, notice: "Lote encerrado com sucesso"
  end

  def canceled
    @lot = Lot.find(params[:id])
    @lot.canceled!
    redirect_to @lot, notice: "Lote cancelado com sucesso"
  end
  
  def aprovated
    @lot = Lot.find(params[:id])

    if current_user.id != @lot.user_id
      if @lot.lot_items.present?
        UserAprovated.create!(user: current_user, lot: @lot, date_aprovated: Date.today)
        @lot.aprovated!
        redirect_to @lot, notice: "Lote aprovado com sucesso"
      else
        redirect_to @lot, notice: "Não é possível aprovar lotes sem itens adicionados"
      end
    else
      redirect_to @lot, notice: "Você não pode aprovar lotes criados pelo seu usuário"
    end
    
  end

  def bid
    @lot = Lot.find(params[:id])
    val = params[:val]
    @user_bid_lot = UserBidLot.new(user: current_user, lot: @lot, bid_amount: val)

    if @user_bid_lot.valid? && @lot.available_for_bid
      @user_bid_lot.save!
        redirect_to @lot, notice: 'Lance computado!'
    else
        flash.now[:notice] = 'Lance não computado!'  
        render 'show'
    end  
  end

end