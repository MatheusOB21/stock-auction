class HomeController < ApplicationController
    before_action :authenticate_user!, only:[:show]
    def index
        @lots_in_progress = Lot.where(["limit_date > ? and start_date <= ? and status = ?" , Date.today, Date.today, 3])
        @lots_future = Lot.where(["limit_date > ? and start_date > ? and status = ?" , Date.today, Date.today, 3])
    end
end