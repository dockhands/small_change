class RatingsController < ApplicationController

    before_action :authenticate_user!

    def create
      @deed          = Deed.find params[:deed_id]
      rating_params  = params.require(:rating).permit(:body, :score)
      @rating = @deed.ratings.build(rating_params)
      @rating.user     = current_user
      if @rating.save
        flash[:success] = "Thanks for rating!"
        redirect_to deed_path(@deed)
      else
        flash[:danger] = "Can't rate! Rated already?"
        redirect_to deed_path(@deed)
      end
    end
  
    def destroy
      
        @deed = Deed.find params[:deed_id]
        @rating = Rating.find params[:id]
        @rating.destroy
        flash[:alert] = "Removed rating"
        redirect_to deed_path(@deed)
    end

end
