class DeedsController < ApplicationController

    def index
    end

    def new
        @deed = Deed.new

    end

    def create
        @deed = Deed.new deed_params
    
        if @deed.save
            flash[:success] = "Deed made!"
            redirect_to deed_path(@deed)
        else
            if @deed.errors
                flash.now[:danger] = @deed.errors.full_messages.join(", ")
            end
            render :new
        end


    end 


    def show
        
    end 


    private 

    def deed_params
        params.require(:deed).permit(:deed, :title, :body, :money_required, :image_url, :location)
    end
end
