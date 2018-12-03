class RatingsController < ApplicationController

    before_action :authenticate_user

    def create
      rating        = Rating.new
      deed          = Deed.find params[:deed_id]
      rating.deed = deed
      rating.user     = current_user
      if rating.save
        flash[:success] = "Thanks for rating!"
        redirect_to deed_path(deed)
      else
        flash[:danger] = "Can't rate! Rated already?"
        redirect_to deed_path(deed)
      end
    end
  

end
