class BlacklistsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    
    Blacklist.create!(cpf: @user.cpf)
    redirect_to users_path, notice: "Usuário bloqueado com sucesso!"
  end

  def destroy
    @user = User.find(params[:user_id])
    @cpf_blacklist = Blacklist.find(params[:id])
    
    @cpf_blacklist.destroy!
    redirect_to users_path, notice: "Usuário desbloqueado com sucesso!"
  end
end