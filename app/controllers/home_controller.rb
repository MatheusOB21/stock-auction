class HomeController < ApplicationController
    def index
      @lots_in_progress = Lot.where(["start_date <= ? and limit_date >= ? and status = ?" , Date.today, Date.today, 3])
      @lots_future = Lot.where(["start_date > ? and status = ?" ,Date.today, 3])
    end

    def show
      @code = params["query"]
      @lots = Lot.where(["code LIKE ? and status = ?" , "%#{@code.upcase}%", 3])   
    end
end