class UsersController < ApplicationController
  
  def index
    @blacklists = Blacklist.all 
    @users_regular = User.where("email NOT LIKE ?","%leilaodogalpao.com.br")
  end

end