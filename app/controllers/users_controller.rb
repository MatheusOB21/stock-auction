class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_page
  
  def index
    @blacklists = Blacklist.all 
    @users_regular = User.where("email NOT LIKE ?","%leilaodogalpao.com.br")
  end

end