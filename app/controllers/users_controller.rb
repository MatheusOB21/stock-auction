class UsersController < ApplicationController
  
  def index
    @users_regular = User.where("email NOT LIKE ?","%leilaodogalpao.com.br")
  end

  def block
    @user = User.find(params[:id])
    Blacklist.create!(cpf: @user.cpf)
    redirect_to users_path, notice: "Usuário bloqueado com sucesso!"
  end

end