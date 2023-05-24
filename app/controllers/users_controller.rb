class UsersController < ApplicationController
  
  def index
    @users_regular = User.where("email NOT LIKE ?","%leilaodogalpao.com.br")
  end

end