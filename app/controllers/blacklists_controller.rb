class BlacklistsController < ApplicationController

  def new
    @blacklist = Blacklist.new
  end
  
  def create
    blacklist_params = params.require(:blacklist).permit(:cpf)
    
    @blacklist = Blacklist.new(blacklist_params)
    if @blacklist.save
      redirect_to users_path, notice: "Usuário bloqueado com sucesso!"
    else
      render 'new'
    end  
  end

  def block
    @user = User.find(params[:id])
    
    Blacklist.create!(cpf: @user.cpf)
    redirect_to users_path, notice: "Usuário bloqueado com sucesso!"
  end

  def destroy
    @cpf_blacklist = Blacklist.find(params[:id])
    
    @cpf_blacklist.destroy!
    redirect_to users_path, notice: "Usuário desbloqueado com sucesso!"
  end
end