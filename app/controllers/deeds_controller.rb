class DeedsController < ApplicationController

    before_action :find_deed, only: [:show, :edit, :update, :destroy]

    def index

        @deeds = Deed.all.order(created_at: :desc)
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
        render :show 
        
    end 

    def edit 
    end 

    def update
        if @deed.update deed_params
          redirect_to deed_path(@deed.id)
        else
          if @deed.errors.present?
            flash.now[:danger] = @deed.errors.full_messages.join(" • ")
          end 
          render :edit
        end
    end



    private 

    def deed_params
        params.require(:deed).permit(:deed, :title, :body, :money_required, :image_url, :location)
    end

    def find_deed
        @deed = Deed.find params[:id]
    end
end
