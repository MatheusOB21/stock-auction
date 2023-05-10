class HomeController < ApplicationController
    before_action :authenticate_user!, only:[:show]
    def index
        @lots_in_progress = Lot.where(["start_date <= ? and status = ?" , Date.today, 3])
        @lots_future = Lot.where(["start_date > ? and status = ?" , Date.today, 3])
    end
end