class HomeController < ApplicationController
    def index
      @lots_in_progress = Lot.where(["start_date <= ? and limit_date >= ? and status = ?" , Date.today, Date.today, 3])
      @lots_future = Lot.where(["start_date > ? and status = ?" ,Date.today, 3])
    end

    def show 
      @code = params["query"].upcase
      @code = @code.delete(" ")
      
      @lots = Lot.where(["code LIKE ? and status = ?" , "%#{@code}%", 3]).to_a
      
      @items = Item.where(["name LIKE ?" , "%#{@code}%"])  
      @items.each do |item|
        @lots.push(item.lot)
      end

    end
end