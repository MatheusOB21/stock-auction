class LotsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :pendents, :aprovated, :bid, :finished, :finished_details]
  before_action :admin_page, only:[:new, :create, :pendents, :finished, :finished_details]
  before_action :find_lot, only:[:bid, :aprovated, :canceled, :closed]

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
    @lot = Lot.find(params[:id])
    @lot_questions = @lot.questions.where("status = ?", 0)

    if @lot.aprovated? && !@lot.finished_bids
    elsif user_signed_in?
      if current_user.is_admin 
      elsif @lot.finished_bids && @lot.last_bid.present?
        if current_user == @lot.last_bid.user && @lot.closed?
        else
          redirect_to root_path, notice: "Você não tem acesso a essa página"
        end
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
    @lot.closed!
    @lot.last_bid.won!
    
    @lot.user_bid_lots.where(status: 'bid').each do |user_bid_lot|
      user_bid_lot.loser!
    end
    
    redirect_to @lot, notice: "Lote encerrado com sucesso"
  end

  def canceled
    @lot.canceled!
    @lot_items = @lot.lot_items
    @lot_items.destroy_all
    redirect_to @lot, notice: "Lote cancelado com sucesso"
  end
  
  def aprovated
    if @lot.lot_items.present?
      @user_approves = UserAprovated.new(user: current_user, lot: @lot, date_aprovated: Date.today)
      if @user_approves.save
        @lot.aprovated!
        redirect_to @lot, notice: "Lote aprovado com sucesso"
      else
        flash.now[:notice] = 'Não foi possível aprovar o lote!'  
        render 'show'
      end
    else
      redirect_to @lot, notice: "Não é possível aprovar lotes sem itens adicionados"
    end
  end

  def bid
    val = params[:val]
    @user_bid_lot = UserBidLot.new(user: current_user, lot: @lot, bid_amount: val)

    if @user_bid_lot.valid? && @lot.available_for_bid
      if current_user.block?
        redirect_to @lot, notice: 'Sua conta está suspensa, não pode dar lance!' 
      else
        @user_bid_lot.save!
        redirect_to @lot, notice: 'Lance computado!'
      end
    else
        flash.now[:notice] = 'Lance não computado!'  
        render 'show'
    end  
  end

  private 

  def find_lot
    @lot = Lot.find(params[:id])
  end

end